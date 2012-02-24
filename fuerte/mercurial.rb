require 'formula'

class Mercurial < Formula
  homepage 'http://mercurial.selenic.com/'
  url 'http://mercurial.selenic.com/release/mercurial-2.1.tar.gz'
  sha1 'f649a0b33e0cafb3e5867a2e970f41eb887d3fab'
  head 'http://selenic.com/repo/hg', :using => :hg

#  depends_on 'docutils' => :python if ARGV.build_head? or ARGV.include? "--doc"

#  def options
#    [["--doc", "build the documentation. Depends on 'docutils' module."]]
#  end

  # Remove the error codes on things like "no changes found"
  # Will be in next release
  # See: http://selenic.com/hg/rev/a3dcc59054ca
  def patches
    DATA
  end

  def install
    # Don't add compiler specific flags so we can build against
    # System-provided Python.
    ENV.minimal_optimization

    # Force the binary install path to the Cellar
    inreplace "Makefile",
      "setup.py $(PURE) install",
      "setup.py $(PURE) install --install-scripts=\"#{libexec}\""

    # Make Mercurial into the Cellar.
    # The documentation must be built when using HEAD
#    if ARGV.build_head? or ARGV.include? "--doc"
#      system "make", "doc"
#    end
    system "make", "PREFIX=#{prefix}", "build"
    system "make", "PREFIX=#{prefix}", "install-bin"

    # Now we have lib/python2.x/site-packages/ with Mercurial
    # libs in them. We want to move these out of site-packages into
    # a self-contained folder. Let's choose libexec.
    libexec.install Dir["#{lib}/python*/site-packages/*"]

    # Symlink the hg binary into bin
    bin.install_symlink libexec+'hg'
    # Symlink the python library back to lib
    (lib+'python2.7/site-packages/').install_symlink libexec+'mercurial'

    # Remove the hard-coded python invocation from hg
    inreplace bin+'hg', %r[#!/.*/python/.*], '#!/usr/bin/env python'

    # Install some contribs
    bin.install 'contrib/hgk'

    # Install man pages
    man1.install 'doc/hg.1'
    man5.install 'doc/hgignore.5', 'doc/hgrc.5'
  end

  def caveats
    s = ""
    if ARGV.build_head?
      s += <<-EOS.undent
        As mercurial is required to get its own repository, there are now two
        installations of mercurial on this machine.
        If the previous installation has been done through Homebrew, the old version
        needs to be removed and the new one needs to be linked :

          brew cleanup mercurial && brew link mercurial

      EOS
    end
    return s
  end
end


__END__

# HG changeset patch
# User Matt Mackall <mpm@selenic.com>
# Date 1328911770 21600
# Node ID a3dcc59054cac3a78d0d5e5402680b17a396d59e
# Parent  d75aa756149bfd54b1f7f84b86072b3c1a50d683
pull: backout change to return code

This bit a number of people.

diff -r d75aa756149b -r a3dcc59054ca mercurial/commands.py
--- a/mercurial/commands.py	Fri Feb 10 22:34:13 2012 +0100
+++ b/mercurial/commands.py	Fri Feb 10 16:09:30 2012 -0600
@@ -4261,7 +4261,7 @@
 
 def postincoming(ui, repo, modheads, optupdate, checkout):
     if modheads == 0:
-        return 1
+        return
     if optupdate:
         movemarkfrom = repo['.'].node()
         try:
@@ -4312,8 +4312,7 @@
     If SOURCE is omitted, the 'default' path will be used.
     See :hg:`help urls` for more information.
 
-    Returns 0 on success, 1 if no changes found or an update had
-    unresolved files.
+    Returns 0 on success, 1 if an update had unresolved files.
     """
     source, branches = hg.parseurl(ui.expandpath(source), opts.get('branch'))
     other = hg.peer(repo, opts, source)
diff -r d75aa756149b -r a3dcc59054ca tests/test-bookmarks-pushpull.t
--- a/tests/test-bookmarks-pushpull.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-bookmarks-pushpull.t	Fri Feb 10 16:09:30 2012 -0600
@@ -44,7 +44,6 @@
   pulling from ../a
   no changes found
   importing bookmark X
-  [1]
   $ hg bookmark
      X                         0:4e3505fd9583
      Y                         0:4e3505fd9583
@@ -185,7 +184,6 @@
   no changes found
   divergent bookmark X stored as X@1
   importing bookmark Z
-  [1]
   $ hg clone http://localhost:$HGPORT/ cloned-bookmarks
   requesting all changes
   adding changesets
diff -r d75aa756149b -r a3dcc59054ca tests/test-bundle.t
--- a/tests/test-bundle.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-bundle.t	Fri Feb 10 16:09:30 2012 -0600
@@ -85,7 +85,6 @@
   pulling from ../full.hg
   searching for changes
   no changes found
-  [1]
 
 Pull full.hg into empty (using --cwd)
 
@@ -120,7 +119,6 @@
   pulling from full.hg
   searching for changes
   no changes found
-  [1]
 
 Pull full.hg into empty (using -R)
 
@@ -128,7 +126,6 @@
   pulling from full.hg
   searching for changes
   no changes found
-  [1]
 
 Rollback empty
 
diff -r d75aa756149b -r a3dcc59054ca tests/test-convert.t
--- a/tests/test-convert.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-convert.t	Fri Feb 10 16:09:30 2012 -0600
@@ -293,7 +293,6 @@
   pulling from ../a
   searching for changes
   no changes found
-  [1]
   $ touch bogusfile
 
 should fail
diff -r d75aa756149b -r a3dcc59054ca tests/test-hook.t
--- a/tests/test-hook.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-hook.t	Fri Feb 10 16:09:30 2012 -0600
@@ -196,7 +196,6 @@
   listkeys hook: HG_NAMESPACE=phases HG_VALUES={'cb9a9f314b8b07ba71012fcdbc544b5a4d82ff5b': '1', 'publishing': 'True'} 
   listkeys hook: HG_NAMESPACE=bookmarks HG_VALUES={'bar': '0000000000000000000000000000000000000000', 'foo': '0000000000000000000000000000000000000000'} 
   importing bookmark bar
-  [1]
   $ cd ../a
 
 test that prepushkey can prevent incoming keys
diff -r d75aa756149b -r a3dcc59054ca tests/test-https.t
--- a/tests/test-https.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-https.t	Fri Feb 10 16:09:30 2012 -0600
@@ -160,7 +160,6 @@
   pulling from https://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
   $ mv copy-pull/.hg/hgrc.bu copy-pull/.hg/hgrc
 
 cacert configured globally, also testing expansion of environment
@@ -172,13 +171,11 @@
   pulling from https://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
   $ P=`pwd` hg -R copy-pull pull --insecure
   warning: localhost certificate with fingerprint 91:4f:1a:ff:87:24:9c:09:b6:85:9b:88:b1:90:6d:30:75:64:91:ca not verified (check hostfingerprints or web.cacerts config setting)
   pulling from https://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
 
 cacert mismatch
 
@@ -191,7 +188,6 @@
   pulling from https://127.0.0.1:$HGPORT/
   searching for changes
   no changes found
-  [1]
   $ hg -R copy-pull pull --config web.cacerts=pub-other.pem
   abort: error: *:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed (glob)
   [255]
@@ -200,7 +196,6 @@
   pulling from https://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
 
 Test server cert which isn't valid yet
 
@@ -260,7 +255,6 @@
   pulling from https://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
 
 Test https with cacert and fingerprint through proxy
 
@@ -268,12 +262,10 @@
   pulling from https://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
   $ http_proxy=http://localhost:$HGPORT1/ hg -R copy-pull pull https://127.0.0.1:$HGPORT/
   pulling from https://127.0.0.1:$HGPORT/
   searching for changes
   no changes found
-  [1]
 
 Test https with cert problems through proxy
 
diff -r d75aa756149b -r a3dcc59054ca tests/test-mq-qimport-fail-cleanup.t
--- a/tests/test-mq-qimport-fail-cleanup.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-mq-qimport-fail-cleanup.t	Fri Feb 10 16:09:30 2012 -0600
@@ -34,7 +34,6 @@
   b.patch
 
   $ hg pull -q -r 0 . # update phase
-  [1]
   $ hg qimport -r 0
   abort: revision 0 is not mutable
   (see "hg help phases" for details)
diff -r d75aa756149b -r a3dcc59054ca tests/test-pending.t
--- a/tests/test-pending.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-pending.t	Fri Feb 10 16:09:30 2012 -0600
@@ -102,7 +102,6 @@
   rollback completed
   abort: pretxnchangegroup hook failed
   pull 0000000000000000000000000000000000000000
-  [1]
 
 test external hook
 
@@ -118,4 +117,3 @@
   rollback completed
   abort: pretxnchangegroup hook exited with status 1
   pull 0000000000000000000000000000000000000000
-  [1]
diff -r d75aa756149b -r a3dcc59054ca tests/test-phases-exchange.t
--- a/tests/test-phases-exchange.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-phases-exchange.t	Fri Feb 10 16:09:30 2012 -0600
@@ -136,7 +136,6 @@
   pulling from ../alpha
   searching for changes
   no changes found
-  [1]
   $ hgph
   o  4 public a-D - b555f63b6063
   |
@@ -344,7 +343,6 @@
   pulling from ../alpha
   searching for changes
   no changes found
-  [1]
   $ hgph
   @  6 public n-B - 145e75495359
   |
@@ -777,7 +775,6 @@
   pulling from ../mu
   searching for changes
   no changes found
-  [1]
   $ hgph
   @  11 draft A-secret - 435b5d83910c
   |
@@ -930,7 +927,6 @@
   pulling from http://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
   $ hg phase f54f1bb90ff3
   2: draft
 
diff -r d75aa756149b -r a3dcc59054ca tests/test-pull-r.t
--- a/tests/test-pull-r.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-pull-r.t	Fri Feb 10 16:09:30 2012 -0600
@@ -100,5 +100,4 @@
 This used to abort: received changelog group is empty:
 
   $ hg pull -qr 1 ../repo
-  [1]
 
diff -r d75aa756149b -r a3dcc59054ca tests/test-pull.t
--- a/tests/test-pull.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-pull.t	Fri Feb 10 16:09:30 2012 -0600
@@ -48,7 +48,6 @@
   pulling from http://foo@localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
 
   $ hg rollback --dry-run --verbose
   repository tip rolled back to revision -1 (undo pull: http://foo:***@localhost:$HGPORT/)
@@ -78,7 +77,6 @@
   [255]
 
   $ hg pull -q file:../test
-  [1]
 
 It's tricky to make file:// URLs working on every platform with
 regular shell commands.
@@ -90,4 +88,3 @@
 
   $ URL=`python -c "import os; print 'file://localhost' + ('/' + os.getcwd().replace(os.sep, '/')).replace('//', '/') + '/../test'"`
   $ hg pull -q "$URL"
-  [1]
diff -r d75aa756149b -r a3dcc59054ca tests/test-ssh.t
--- a/tests/test-ssh.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-ssh.t	Fri Feb 10 16:09:30 2012 -0600
@@ -80,7 +80,6 @@
   pulling from ssh://user@dummy/remote
   searching for changes
   no changes found
-  [1]
 
 local change
 
@@ -199,7 +198,6 @@
   no changes found
   updating bookmark foo
   importing bookmark foo
-  [1]
   $ hg book -d foo
   $ hg push -B foo
   pushing to ssh://user@dummy/remote
diff -r d75aa756149b -r a3dcc59054ca tests/test-subrepo.t
--- a/tests/test-subrepo.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-subrepo.t	Fri Feb 10 16:09:30 2012 -0600
@@ -580,7 +580,6 @@
   cloning subrepo s from $TESTTMP/sub/repo/s (glob)
   2 files updated, 0 files merged, 0 files removed, 0 files unresolved
   $ hg -q -R repo2 pull -u
-  [1]
   $ echo 1 > repo2/s/a
   $ hg -R repo2/s ci -m2
   $ hg -q -R repo2/s push
@@ -639,7 +638,6 @@
   pulling from issue1852a
   searching for changes
   no changes found
-  [1]
 
 Try the same, but with pull -u
 
diff -r d75aa756149b -r a3dcc59054ca tests/test-treediscovery-legacy.t
--- a/tests/test-treediscovery-legacy.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-treediscovery-legacy.t	Fri Feb 10 16:09:30 2012 -0600
@@ -48,7 +48,6 @@
   $ hg pull -R empty1 $remote
   pulling from http://localhost:$HGPORT/
   no changes found
-  [1]
   $ hg push -R empty1 $remote
   pushing to http://localhost:$HGPORT/
   no changes found
@@ -108,7 +107,6 @@
   pulling from http://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
   $ hg push $remote
   pushing to http://localhost:$HGPORT/
   searching for changes
@@ -233,7 +231,6 @@
   pulling from http://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
   $ hg push $remote
   pushing to http://localhost:$HGPORT/
   searching for changes
@@ -278,7 +275,6 @@
   pulling from http://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
   $ hg push $remote
   pushing to http://localhost:$HGPORT/
   searching for changes
diff -r d75aa756149b -r a3dcc59054ca tests/test-treediscovery.t
--- a/tests/test-treediscovery.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-treediscovery.t	Fri Feb 10 16:09:30 2012 -0600
@@ -42,7 +42,6 @@
   $ hg pull -R empty1 $remote
   pulling from http://localhost:$HGPORT/
   no changes found
-  [1]
   $ hg push -R empty1 $remote
   pushing to http://localhost:$HGPORT/
   no changes found
@@ -102,7 +101,6 @@
   pulling from http://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
   $ hg push $remote
   pushing to http://localhost:$HGPORT/
   searching for changes
@@ -221,7 +219,6 @@
   pulling from http://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
   $ hg push $remote
   pushing to http://localhost:$HGPORT/
   searching for changes
@@ -266,7 +263,6 @@
   pulling from http://localhost:$HGPORT/
   searching for changes
   no changes found
-  [1]
   $ hg push $remote
   pushing to http://localhost:$HGPORT/
   searching for changes
diff -r d75aa756149b -r a3dcc59054ca tests/test-url-rev.t
--- a/tests/test-url-rev.t	Fri Feb 10 22:34:13 2012 +0100
+++ b/tests/test-url-rev.t	Fri Feb 10 16:09:30 2012 -0600
@@ -141,7 +141,6 @@
 No new revs, no update:
 
   $ hg pull -qu
-  [1]
 
   $ hg parents -q
   0:1f0dee641bb7
diff --git a/setup.py b/setup.py
--- a/setup.py
+++ b/setup.py
@@ -452,10 +452,19 @@
 if sys.platform == 'darwin' and os.path.exists('/usr/bin/xcodebuild'):
     # XCode 4.0 dropped support for ppc architecture, which is hardcoded in
     # distutils.sysconfig
-    version = runcmd(['/usr/bin/xcodebuild', '-version'], {})[0].splitlines()[0]
-    # Also parse only first digit, because 3.2.1 can't be parsed nicely
-    if (version.startswith('Xcode') and
-        StrictVersion(version.split()[1]) >= StrictVersion('4.0')):
+    version = runcmd(['/usr/bin/xcodebuild', '-version'], {})[0].splitlines()
+    if version:
+        # parse only first digit, because 3.2.1 can't be parsed nicely
+        version = version.splitlines()[0]
+        xcode4 = (version.startswith('Xcode') and
+                  StrictVersion(version.split()[1]) >= StrictVersion('4.0'))
+    else:
+        # xcodebuild returns empty (?) on OS X Lion with XCode 4.3 not
+        # installed, but instead with only command-line tools. Assume
+        # that only happens on >= Lion, thus no PPC support.
+        xcode4 = True
+
+    if xcode4:
         os.environ['ARCHFLAGS'] = ''
 
 setup(name='mercurial',


