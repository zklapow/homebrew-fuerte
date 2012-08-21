#!/usr/bin/env python
from __future__ import print_function

import os
import sys

from tempfile import mkdtemp
from xml.etree import ElementTree as ET

try:
    import rosdep2.catkin_support
except ImportError:
    print("Please sudo pip install -U rosdep", file=sys.stderr)
    sys.exit(2)

def parse_stack_xml(et):
    ret = {}
    for child in et:
        last = None
        if child.tag in ret.keys():
            last = ret[child.tag]
            if type(last) == list:
                last.append(child.text)
                ret[child.tag] = last
            elif type(last) == str:
                l = [last, child.text]
                ret[child.tag] = l
        else:
            ret[child.tag] = child.text
    return ret

def make_working(working_dir):
    """Creates the working directory if it doesn't exist yet"""
    if not os.path.exists(working_dir):
        os.makedirs(working_dir)

def camelcase(input):
    temp = str(input)
    temp.replace('-', '_')
    return ''.join([str.capitalize(x) for x in temp.split('_')])

def detect_scm_type(url):
    # TODO: determine this by the url, or hope they had a scm tag to the release file
    return 'git'

def generate_deps(ros_distro, rosdep_keys):
    if not rosdep_keys:
        return None

    if type(rosdep_keys) == str:
        rosdep_keys = [rosdep_keys]
    deps = []
    view = rosdep2.catkin_support.get_catkin_view(ros_distro, 'osx', 'mountain')
    for rosdep_key in rosdep_keys:
        inst, rule = view.lookup(rosdep_key).get_rule_for_platform('osx', 'mountain', rosdep2.catkin_support.default_installers['osx'], rosdep2.catkin_support.APT_INSTALLER)
        resolution = rosdep2.catkin_support.get_installer(inst).resolve(rule)
        deps.append((inst, resolution))
    return deps

special_installs = {}
special_installs['genlisp'] = \
'''
  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "mkdir #{prefix}/lib/python2.7/site-packages/"
    system "cd build && make install"
  end
'''

pipkey_to_importtest_map = {}
pipkey_to_importtest_map['empy'] = 'em'

def generate_brew(stack_xml, repo_url, ros_distro):
    # Homebrew Formula Template
    template = \
'''
require 'formula'

class %(formula_class_name)s < Formula
  url '%(url)s', {:using => :%(scm_type)s, :tag => '%(scm_tag)s'}
  homepage '%(homepage)s'
  version '%(version)s'

%(depends_def)s

%(install)s
end
'''
    # Get the output file name
    file_name = stack_xml['name']
    # Build the template variables
    template_vars = {}
    template_vars['formula_class_name'] = camelcase(file_name)
    template_vars['url'] = repo_url
    template_vars['scm_type'] = detect_scm_type(repo_url)
    # TODO: Maybe the scm_tag should be more portable...
    template_vars['scm_tag'] = 'upstream/'+stack_xml['version']
    template_vars['homepage'] = stack_xml['url']
    template_vars['version'] = stack_xml['version']
    # Generate a list of (installer_key, install_key) pairs for the deps using rosdep
    if 'depends' in stack_xml.keys():
        deps = generate_deps(ros_distro, stack_xml['depends'])
    else:
        deps = []
    depends_def = ""
    pip_requirements = ""
    for dep in deps:
        # Get a list of the resolutions
        resolutions = dep[1]
        installer = dep[0]
        # There could be more than one resolved
        for resolved in resolutions:
            # If it is pip
            if installer == 'pip':
                # Look for special import test keys
                if resolved in pipkey_to_importtest_map:
                    depends_def += "  depends_on LanguageModuleDependency.new :python, '%s', '%s'\n"%(resolved, pipkey_to_importtest_map[resolved])
                else:
                    depends_def += "  depends_on '%s' => :python\n"%resolved
                pip_requirements += resolved+'\n'
                continue
            # If it is homebrew
            if installer == 'homebrew':
                # If it contains a / it is an :alt
                if resolved.find('/') != -1:
                    depends_def += "  depends_on '%s' => :alt\n"%resolved
                    continue
                depends_def += "  depends_on '%s'\n"%resolved
    template_vars['depends_def'] = depends_def
    # Look for special install instructions
    if file_name in special_installs:
        template_vars['install'] = special_installs[file_name]
    else:
        template_vars['install'] = \
'''
  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end
'''
    # Fill out the template
    formula = template%template_vars
    # Write the formula to file
    formula_file = open(file_name+'.rb', 'w')
    formula_file.write(formula)
    formula_file.close()
    # Write the pip requirements file
    if pip_requirements:
        pip_requirements_file = open(file_name+'_pip_requirements.txt', 'w')
        pip_requirements_file.write(pip_requirements)
        pip_requirements_file.close()

def main(ros_distro, xml_path, repo_url):
    t = ET.parse(xml_path)
    stack_xml = parse_stack_xml(t.getroot())

    try:
        generate_brew(stack_xml, repo_url, ros_distro)
    except rosdep2.catkin_support.ValidationFailed as e:
        print(e.args[0], file=sys.stderr)
        sys.exit(1)
    except (KeyError, rosdep2.ResolutionError) as e:
        if isinstance(e, KeyError):
            rosdep_key = str(e)
        else:
            rosdep_key = e.rosdep_key
        print("""Cannot resolve dependency [%(rosdep_key)s].

If [%(rosdep_key)s] is catkin project, make sure it has been added to the gbpdistro file.

If [%(rosdep_key)s] is a system dependency, make sure there is a rosdep.yaml entry
for it in your sources.
"""%locals(), file=sys.stderr)
        sys.exit(3)
    sys.exit(0)

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: generate-homebrew-formula <ros_distro> <path/to/stack.xml> <repo_url>")
        sys.exit(4)
    main(sys.argv[1], sys.argv[2], sys.argv[3])
