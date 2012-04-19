
require 'formula'

class Rx < Formula
  url 'git://github.com/wg-debs/rx-release.git', {:using => :git, :tag => 'upstream/1.8.6'}
  homepage 'http://ros.org/wiki/rx'
  version '1.8.6'

  depends_on 'ros/fuerte/rospack' => :alt
  depends_on 'ros/fuerte/ros_comm' => :alt
  depends_on 'ros/fuerte/catkin' => :alt
  depends_on 'ros/fuerte/swig-wx' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
