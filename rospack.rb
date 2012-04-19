
require 'formula'

class Rospack < Formula
  url 'git://github.com/wg-debs/rospack.git', {:using => :git, :tag => 'upstream/2.0.12'}
  homepage 'http://www.ros.org'
  version '2.0.12'

  depends_on 'boost'
  depends_on 'gtest'
  depends_on 'ros/fuerte/catkin' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
