
require 'formula'

class UrdfdomHeaders < Formula
  url 'git://github.com/wg-debs/urdfdom_headers-release.git', {:using => :git, :tag => 'upstream/0.2.0'}
  homepage 'http://www.ros.org/wiki/urdf'
  version '0.2.0'

  depends_on 'boost'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
