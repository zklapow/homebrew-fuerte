
require 'formula'

class Ros < Formula
  url 'git://github.com/wg-debs/ros.git', {:using => :git, :tag => 'upstream/1.8.4'}
  homepage 'http://www.ros.org'
  version '1.8.4'

  depends_on 'ros/fuerte/rospack' => :alt
  depends_on 'rospkg' => :python
  depends_on 'gtest'
  depends_on 'nose' => :python
  depends_on 'ros/fuerte/catkin' => :alt
  depends_on 'boost'
  depends_on 'pkg-config'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
