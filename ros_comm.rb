
require 'formula'

class RosComm < Formula
  url 'git://github.com/wg-debs/ros_comm-release.git', {:using => :git, :tag => 'upstream/1.8.15'}
  homepage 'http://www.ros.org/wiki/ros_comm'
  version '1.8.15'

  depends_on 'boost'
  depends_on 'zklapow/fuerte/langs' => :alt
  depends_on 'log4cxx'
  depends_on 'paramiko' => :python
  depends_on LanguageModuleDependency.new :python, 'PyYAML', 'yaml'
  depends_on 'zklapow/fuerte/ros' => :alt
  depends_on 'zklapow/fuerte/roscpp_core' => :alt
  depends_on 'zklapow/fuerte/std_msgs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
