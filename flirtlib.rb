
require 'formula'

class Flirtlib < Formula
  url 'git://github.com/wg-debs/flirtlib-release.git', {:using => :git, :tag => 'upstream/0.1.5'}
  homepage 'http://www.informatik.uni-freiburg.de/~tipaldi/homepage.html'
  version '0.1.5'

  depends_on 'boost'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
