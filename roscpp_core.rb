
require 'formula'

class RoscppCore < Formula
  url 'git://github.com/wg-debs/roscpp_core-release.git', {:using => :git, :tag => 'upstream/0.2.6'}
  homepage 'http://www.ros.org/wiki/roscpp_core'
  version '0.2.6'

  depends_on 'boost'
  depends_on 'zklapow/fuerte/ros' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
