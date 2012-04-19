
require 'formula'

class Flann < Formula
  url 'git://github.com/wg-debs/flann.git', {:using => :git, :tag => 'upstream/1.7.1'}
  homepage 'http://people.cs.ubc.ca/~mariusm/index.php/FLANN/FLANN'
  version '1.7.1'

  depends_on 'cmake'
  depends_on 'numpy' => :python
  depends_on 'gtest'
  depends_on 'tbb'
  depends_on 'boost'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
