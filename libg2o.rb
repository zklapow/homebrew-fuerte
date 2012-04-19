
require 'formula'

class Libg2o < Formula
  url 'git://github.com/wg-debs/libg2o-release.git', {:using => :git, :tag => 'upstream/26.0.1'}
  homepage 'https://openslam.informatik.uni-freiburg.de/data/svn/g2o/trunk/'
  version '26.0.1'

  depends_on 'suite-sparse'
  depends_on 'cmake'
  depends_on 'eigen'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
