
require 'formula'

class Srdfdom < Formula
  url 'git://github.com/wg-debs/srdfdom-release.git', {:using => :git, :tag => 'upstream/0.1.1'}
  homepage 'http://www.ros.org/wiki/srdf'
  version '0.1.1'

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
