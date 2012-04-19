
require 'formula'

class StdMsgs < Formula
  url 'git://github.com/wg-debs/std_msgs.git', {:using => :git, :tag => 'upstream/0.4.6'}
  homepage 'http://www.ros.org/wiki/std_msgs'
  version '0.4.6'

  depends_on 'ros/fuerte/roscpp_core' => :alt
  depends_on 'ros/fuerte/langs' => :alt
  depends_on 'ros/fuerte/genmsg' => :alt
  depends_on 'ros/fuerte/catkin' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
