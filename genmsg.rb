
require 'formula'

class Genmsg < Formula
  url 'git://github.com/wg-debs/genmsg.git', {:using => :git, :tag => 'upstream/0.3.4'}
  homepage 'http://www.ros.org/wiki/genmsg'
  version '0.3.4'

  depends_on 'ros/fuerte/catkin' => :alt


  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end
end
