
require 'formula'

class Fcl < Formula
  url 'git://github.com/wg-debs/fcl.git', {:using => :git, :tag => 'upstream/0.1.2'}
  homepage 'https://kforge.ros.org/projects/fcl/'
  version '0.1.2'

  depends_on 'pkg-config'
  depends_on 'cmake'
  depends_on 'ros/fuerte/flann' => :alt
  depends_on 'ros/fuerte/libccd' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
