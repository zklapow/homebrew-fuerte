
require 'formula'

class Libg2o < Formula
  url 'git://github.com/wg-debs/libg2o-release.git', {:using => :git, :tag => 'upstream/0.0.26'}
  homepage 'https://openslam.informatik.uni-freiburg.de/data/svn/g2o/trunk/'
  version '0.0.26'

  depends_on 'eigen'
  depends_on 'suite-sparse'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
