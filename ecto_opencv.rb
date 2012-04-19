
require 'formula'

class EctoOpencv < Formula
  url 'git://github.com/wg-debs/ecto_opencv-release.git', {:using => :git, :tag => 'upstream/0.3.3'}
  homepage 'http://ecto.willowgarage.com'
  version '0.3.3'

  depends_on 'opencv'
  depends_on 'boost'
  depends_on 'ros/fuerte/ecto' => :alt
  depends_on 'ros/fuerte/catkin' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
