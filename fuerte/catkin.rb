require 'formula'

class Catkin < Formula
  url 'https://github.com/willowgarage/catkin/tarball/0.3.19'
  homepage 'http://people.willowgarage.com/straszheim/catkin-dev/catkin/'
  md5 'b0a32f50d474680feb7ad4bc01012af8'
  version '0.3.19'

  def patches
    DATA
  end


  depends_on 'ros/fuerte/swig-wx' => :alt
  depends_on 'ros/fuerte/qt' => :alt
  depends_on 'ros/fuerte/cmake' => :alt
  depends_on 'rosinstall' => :python
  depends_on 'ros/fuerte/pysvn' => :alt
  # I am installing my own version of mercurial to apply a patch
  # see: http://mercurial.selenic.com/bts/issue3277
  depends_on 'ros/fuerte/mercurial' => :alt
  depends_on 'em' => :python
  depends_on 'ros/fuerte/boost' => :alt

  def install
    ENV.append 'PYTHON_PATH', ':/usr/local/lib/python2.7/site-packages/'
    system "mkdir stacks"
    system "cd stacks && rosinstall -n . ../test/test.rosinstall"
    system "cd stacks && ln -s ../toplevel.cmake CMakeLists.txt"
    system "mkdir build"
    system "cd build && cmake ../stacks #{std_cmake_parameters}"
    system "cd build && make"
    system "cd build && make install"
  end
end

__END__
diff --git a/test/test.rosinstall b/test/test.rosinstall
index 812794c..987c101 100644
--- a/test/test.rosinstall
+++ b/test/test.rosinstall
@@ -9,11 +9,6 @@
     version: master
 
 - git:
-    uri: 'git://github.com/ros/rosdep_rules.git'
-    local-name: rosdep_rules
-    version: master
-
-- git:
     uri: 'git://github.com/ros/genmsg.git'
     local-name: genmsg
     version: master


