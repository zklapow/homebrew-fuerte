
require 'formula'

class RosTutorials < Formula
  url 'git://github.com/wg-debs/ros_tutorials.git', {:using => :git, :tag => 'upstream/0.2.14'}
  homepage 'http://ros.org/wiki/ros_tutorials'
  version '0.2.14'

  depends_on 'ros/fuerte/catkin' => :alt
  depends_on 'ros/fuerte/roscpp_core' => :alt
  depends_on 'ros/fuerte/ros_comm' => :alt
  depends_on 'ros/fuerte/std_msgs' => :alt
  depends_on 'qt'
  depends_on 'qt'
  depends_on 'ros/fuerte/common_msgs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
