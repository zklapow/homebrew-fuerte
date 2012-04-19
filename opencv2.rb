
require 'formula'

class Opencv2 < Formula
  url 'git://github.com/wg-debs/opencv2.git', {:using => :git, :tag => 'upstream/2.3.95'}
  homepage 'http://opencv.willowgarage.com'
  version '2.3.95'

  depends_on 'ros/fuerte/catkin' => :alt
  depends_on 'ffmpeg'
  depends_on 'jpeg'
  depends_on 'numpy' => :python
  depends_on 'gtk+'
  depends_on 'libtiff'
  depends_on 'jasper'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
