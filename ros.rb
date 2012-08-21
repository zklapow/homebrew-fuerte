
require 'formula'

class Ros < Formula
  url 'git://github.com/wg-debs/ros-release.git', {:using => :git, :tag => 'upstream/1.8.10'}
  homepage 'http://www.ros.org/wiki/ROS'
  version '1.8.10'

  depends_on 'boost'
  depends_on 'zklapow/fuerte/catkin' => :alt
  depends_on 'gtest'
  depends_on 'nose' => :python
  depends_on 'rospkg' => :python
  depends_on 'zklapow/fuerte/rospack' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
