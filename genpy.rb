
require 'formula'

class Genpy < Formula
  url 'git://github.com/wg-debs/genpy-release.git', {:using => :git, :tag => 'upstream/0.3.7'}
  homepage 'http://www.ros.org/wiki/genpy'
  version '0.3.7'

  depends_on 'zklapow/fuerte/genmsg' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
