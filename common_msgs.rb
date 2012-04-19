
require 'formula'

class CommonMsgs < Formula
  url 'git://github.com/wg-debs/common_msgs.git', {:using => :git, :tag => 'upstream/1.8.3'}
  homepage 'http://www.ros.org'
  version '1.8.3'

  depends_on 'ros/fuerte/std_msgs' => :alt
  depends_on 'ros/fuerte/langs' => :alt
  depends_on 'ros/fuerte/genmsg' => :alt
  depends_on 'ros/fuerte/catkin' => :alt
  depends_on 'ros/fuerte/ros_comm' => :alt


  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end
end
