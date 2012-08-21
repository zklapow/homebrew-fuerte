
require 'formula'

class Urdfdom < Formula
  url 'git://github.com/wg-debs/urdfdom.git', {:using => :git, :tag => 'upstream/0.2.2'}
  homepage 'http://www.ros.org/wiki/urdf'
  version '0.2.2'

  depends_on 'boost'
  depends_on 'ros/fuerte/tinyxml' => :alt
  depends_on 'zklapow/fuerte/urdfdom_headers' => :alt
  depends_on 'zklapow/fuerte/console_bridge' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
