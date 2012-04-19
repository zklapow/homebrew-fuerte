
require 'formula'

class Actionlib < Formula
  url 'git://github.com/wg-debs/actionlib.git', {:using => :git, :tag => 'upstream/1.8.4'}
  homepage 'http://ros.org/wiki/actionlib'
  version '1.8.4'

  depends_on 'ros/fuerte/ros' => :alt
  depends_on 'ros/fuerte/ros_comm' => :alt
  depends_on 'ros/fuerte/common_msgs' => :alt


  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end
end
