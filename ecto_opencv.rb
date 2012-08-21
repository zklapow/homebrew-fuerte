
require 'formula'

class EctoOpencv < Formula
  url 'git://github.com/wg-debs/ecto_opencv-release.git', {:using => :git, :tag => 'upstream/0.4.1'}
  homepage 'http://ecto.willowgarage.com'
  version '0.4.1'

  depends_on 'boost'
  depends_on 'zklapow/fuerte/ecto' => :alt
  depends_on 'opencv'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
