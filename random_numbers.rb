
require 'formula'

class RandomNumbers < Formula
  url 'git://github.com/wg-debs/random_numbers-release.git', {:using => :git, :tag => 'upstream/0.1.1'}
  homepage 'http://ros.org/wiki/random_numbers'
  version '0.1.1'

  depends_on 'boost'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
