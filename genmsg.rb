
require 'formula'

class Genmsg < Formula
  url 'git://github.com/wg-debs/genmsg-release.git', {:using => :git, :tag => 'upstream/0.3.10'}
  homepage 'http://www.ros.org/wiki/genmsg'
  version '0.3.10'




  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
