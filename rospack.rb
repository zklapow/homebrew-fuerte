
require 'formula'

class Rospack < Formula
  url 'git://github.com/wg-debs/rospack-release.git', {:using => :git, :tag => 'upstream/2.0.13'}
  homepage 'http://www.ros.org/wiki/rospack'
  version '2.0.13'

  depends_on 'boost'
  depends_on 'gtest'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
