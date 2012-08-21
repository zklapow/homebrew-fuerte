
require 'formula'

class Opencv2 < Formula
  url 'git://github.com/wg-debs/opencv2-release.git', {:using => :git, :tag => 'upstream/2.4.2'}
  homepage 'http://opencv.org'
  version '2.4.2'

  depends_on 'numpy' => :python
  depends_on 'ffmpeg'
  depends_on 'gtk+'
  depends_on 'jasper'
  depends_on 'jpeg'
  depends_on 'libtiff'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
