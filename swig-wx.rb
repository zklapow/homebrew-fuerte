
require 'formula'

class Swig-wx < Formula
  url 'git://github.com/wg-debs/swig-wx.git', {:using => :git, :tag => 'upstream/1.3.29'}
  homepage 'http://www.swig.org'
  version '1.3.29'




  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
