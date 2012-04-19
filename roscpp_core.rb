
require 'formula'

class RoscppCore < Formula
  url 'git://github.com/wg-debs/roscpp_core.git', {:using => :git, :tag => 'upstream/0.2.3'}
  homepage 'http://www.ros.org/wiki/roscpp_core'
  version '0.2.3'

  depends_on 'ros/fuerte/genmsg' => :alt
  depends_on 'boost'


  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end
end
