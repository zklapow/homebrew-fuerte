
require 'formula'

class Gencpp < Formula
  url 'git://github.com/wg-debs/gencpp-release.git', {:using => :git, :tag => 'upstream/0.3.4'}
  homepage 'http://www.ros.org/wiki/roscpp'
  version '0.3.4'

  depends_on 'zklapow/fuerte/genmsg' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
