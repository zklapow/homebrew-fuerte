
require 'formula'

class RosComm < Formula
  url 'git://github.com/wg-debs/ros_comm.git', {:using => :git, :tag => 'upstream/1.8.7'}
  homepage 'http://www.ros.org'
  version '1.8.7'

  depends_on LanguageModuleDependency.new :python, 'PyYAML', 'yaml'
  depends_on 'ros/fuerte/genmsg' => :alt
  depends_on 'ros/fuerte/catkin' => :alt
  depends_on 'ros/fuerte/roscpp_core' => :alt
  depends_on 'ros/fuerte/std_msgs' => :alt
  depends_on 'paramiko' => :python
  depends_on 'ros/fuerte/ros' => :alt
  depends_on 'boost'
  depends_on 'log4cxx'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
