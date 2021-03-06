
require 'formula'

class Ecto < Formula
  url 'git://github.com/wg-debs/ecto-release.git', {:using => :git, :tag => 'upstream/0.4.0'}
  homepage 'http://ecto.willowgarage.com'
  version '0.4.0'

  depends_on 'boost'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
