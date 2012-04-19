
require 'formula'

class EctoRos < Formula
  url 'git://github.com/wg-debs/ecto_ros-release.git', {:using => :git, :tag => 'upstream/0.3.1'}
  homepage 'http://ecto.willowgarage.com/recognition'
  version '0.3.1'

  depends_on 'ros/fuerte/std_msgs' => :alt
  depends_on 'ros/fuerte/ecto' => :alt
  depends_on 'ros/fuerte/catkin' => :alt
  depends_on 'ros/fuerte/ros_comm' => :alt
  depends_on 'ros/fuerte/common_msgs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
