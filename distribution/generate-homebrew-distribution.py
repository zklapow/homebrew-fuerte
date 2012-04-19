#!/usr/bin/env python

"""
An example of how to use this:
generate-homebrew-distribution.py --working /path/to/working_dir --gbp-repo-file https://raw.github.com/ros/rosdistro/master/releases/fuerte.yaml --resume-on-error
"""

from __future__ import print_function

import os
import optparse
import sys

from tempfile import mkdtemp
from subprocess import Popen, CalledProcessError

try:
    import yaml
except ImportError:
    print("Please install python-yaml", file=sys.stderr)
    sys.exit(1)

try:
    import vcstools
except ImportError:
    print("Please sudo pip install -U vcstools", file=sys.stderr)
    sys.exit(2)

def parse_options():
    import argparse
    parser = argparse.ArgumentParser(description='Creates/updates binaries for each repo described in a gbp-repo file.')
    parser.add_argument('--working', help='A scratch build path. Default: %(default)s',
                        default=mkdtemp())
    parser.add_argument('--gbp-repo-file', help='File path or URL to the gbp-repo file that gives the information about each repo.',
                        default='')
    parser.add_argument('--build_binary', help='Weather or not to generate binaries for distribution or not.', action='store_true')
    parser.add_argument('--redo', help='If this is set repos that have previously been generated will be updated and regenerated.',
                        action='store_true')
    parser.add_argument('--resume-on-error', help='Will continue through repos even if one fails.', action='store_true')
    return parser.parse_args()

def fetch_gbp_file(url, directory):
    from urllib import urlopen
    gbp_file_path = os.path.join(directory, 'distribution.yaml')
    gbp_file = open(gbp_file_path, 'w')
    gbp_file_data = urlopen(url).read()
    gbp_file.write(gbp_file_data)
    return gbp_file_path

def parse_gbp_yaml(file_path):
    from yaml import load
    gbp_yaml = load(open(file_path, 'r'))
    return gbp_yaml

def make_directory(directory):
    """Creates the directory if it doesn't exist yet"""
    if not os.path.exists(directory):
        os.makedirs(directory)

def detect_scm_type(url):
    # TODO: determine this by the url, or hope they had a scm tag to the release file
    return 'git'

def call(working_dir, command, pipe=None):
    print('+ cd %s && ' % working_dir + ' '.join(command))
    process = Popen(command, stdout=pipe, stderr=pipe, cwd=working_dir)
    output, unused_err = process.communicate()
    retcode = process.poll()
    if retcode:
        raise CalledProcessError(retcode, command)
    if pipe:
        return output

def process_repo(repo, ros_distro, repos_dir, build_binary=False, redo=False):
    # Create the repo directory if needed
    repo_dir = os.path.join(repos_dir, repo['name'])
    repo['working_dir'] = repo_dir
    print("+++ Processing repository: [%(name)s] from `%(url)s` in directory [%(working_dir)s]"%repo)
    if not redo:
        if os.path.exists(os.path.join(repo_dir, 'GENERATED')):
            print("  [%(name)s] Distribution generation has already been done on this repo, and redo was not set, skipping..."%repo)
            return
    make_directory(repo_dir)
    # Setup the sources
    src_dir = os.path.join(repo_dir, 'sources')
    repo['src_dir'] = src_dir
    # Detect the scm type
    scm_type = detect_scm_type(repo['url'])
    vcs_client = vcstools.VcsClient(scm_type, src_dir)
    # If the source directory exists, try to update it
    source_ok = False
    if os.path.exists(src_dir):
        # If the source directory contains a repo of the correct type
        # and if the url's match, try to update
        if vcs_client.detect_presence() and vcs_client.get_url() == repo['url']:
            print("  [%(name)s] Sources exist, attempting to update..."%repo)
            vcs_client.update(vcs_client.get_version())
            source_ok = True
        # Else remove the directory so it can get a fresh checkout
        else:
            # Why did it fail?
            if not vcs_client.detect_presence():
                print("  [%(name)s] Sources exist, but scm type doesn't match, deleting..."%repo)
            elif vcs_client.get_url() != repo['url']:
                print("  [%(name)s] Sources exist, but url's don't match, deleting..."%repo)
            else:
                print("  [%(name)s] Sources exist, but could not update, deleting..."%repo)
            # Remove the tree
            from shutil import rmtree
            rmtree(src_dir)
            # Make a new directory to checkout to
            make_directory(src_dir)
    # If the update failed, check it out
    if not source_ok:
        print("  [%(name)s] Fetching sources to %(src_dir)s ..."%repo)
        vcs_client.checkout(repo['url'])
    # Generate a Homebrew formula using the 'generate-homebrew-formula' command
    script_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'generate-homebrew-formula.py')
    stack_path = os.path.abspath(os.path.join(src_dir, 'stack.yaml'))
    call(repo_dir, ['python', script_path, ros_distro, stack_path, repo['url']])
    # If the call was successful, put a GENEREATED file in the directory
    open(os.path.join(repo_dir, 'GENERATED'), 'w').close()

def generate_variant(variant, ros_distro):
    pass

def process_repos(gbp_yaml, args):
    # Get the ROS distribution we are building for:
    ros_distro = gbp_yaml['release-name']
    # For each repo we will:
    #  * Make a subdirectory in the working directory for it
    #  * Checkout the repo into the source directory of the repo directory
    #  * Generate a Homebrew Formula from the stack.yaml using rosdep
    #  * Generate a pip requirements file from the stack.yaml using rosdep
    #  * (binary)Install pip dependencies
    #  * (binary)Install homebrew formula
    #  * (binary)Create a homebrew bottle
    repos = gbp_yaml['gbp-repos']
    make_directory(os.path.join(args.working, 'repos'))
    successes = []
    errors = {}
    for repo in repos:
        try:
            process_repo(repo, ros_distro, os.path.join(args.working, 'repos'), args.build_binary, args.redo)
        except Exception as e:
            print("  [%s] Error occurred while processing: "%repo['name'])
            import traceback
            traceback.print_exc()
            errors[repo['name']] = e
            if not args.resume_on_error:
                sys.exit(3)
            else:
                print("Resuming...")
                continue
        successes.append(repo['name'])
    # Report on the repo generation
    print("+++")
    print("+++ %i out of %i repos succeeded in generating distribution files."%(len(successes), len(repos)))
    print("+++ Repos that failed: ")
    for repo_name in errors.keys():
        print("  %s"%repo_name)
    print("+++")
    return
    # For each variant we will:
    #  * Generate a Homebrew formula
    variants = gbp_yaml['variants']
    for variant in variants:
        generate_variant(variant, ros_distro)

def main(args):
    # Make the working directory if it doesn't already exist
    print("Using working directory: [%s]"%args.working)
    make_directory(args.working)
    gbp_yaml = None
    # If a gbp_repo_file was specified fetch it and load the yaml
    if args.gbp_repo_file:
        print("Fetching `%s` to [%s]"%(args.gbp_repo_file, os.path.join(args.working, 'distribution.yaml')))
        gbp_yaml = parse_gbp_yaml(fetch_gbp_file(args.gbp_repo_file, args.working))
    # Otherwise you need to try and use the distribution.yaml in the working dir
    elif os.path.exists(os.path.join(args.working, 'distribution.yaml')):
        # It exists, use it
        print("No gbp_repo_file specified, using [%s]"%os.path.join(args.working, 'distribution.yaml'))
        gbp_yaml = parse_gbp_yaml(os.path.join(args.working, 'distribution.yaml'))
    else:
        # No gbp_repo_file specified and none in the working dir, error
        print("No gbp_repo_file provided and no distribution.yaml in the working directory, cannot continue.")
        sys.exit(4)
    # Use the yaml to proceed with downloading the repos, generating homebrew formula and pip requirement files
    process_repos(gbp_yaml, args)

if __name__ == "__main__":
    main(parse_options())
