
require 'formula'

class Libccd < Formula
  url 'git://github.com/wg-debs/libccd.git', {:using => :git, :tag => 'upstream/1.2.0'}
  homepage 'http://libccd.danfis.cz/'
  version '1.2.0'

  depends_on 'cmake'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
