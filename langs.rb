
require 'formula'

class Langs < Formula
  url 'git://github.com/wg-debs/langs-release.git', {:using => :git, :tag => 'upstream/0.3.5'}
  homepage 'http://www.ros.org'
  version '0.3.5'

  depends_on 'zklapow/fuerte/catkin' => :alt
  depends_on 'zklapow/fuerte/roscpp_core' => :alt
  depends_on 'zklapow/fuerte/langs-dev' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
