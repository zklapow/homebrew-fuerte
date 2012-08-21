
require 'formula'

class Pcl < Formula
  url 'git://github.com/wg-debs/pcl.git', {:using => :git, :tag => 'upstream/1.6.0'}
  homepage 'http://pointclouds.org/'
  version '1.6.0'

  depends_on 'boost'
  depends_on 'cmake'
  depends_on 'zklapow/fuerte/common_msgs' => :alt
  depends_on 'eigen'
  depends_on 'zklapow/fuerte/flann' => :alt
  depends_on 'mysql'
  depends_on 'qhull'
  depends_on 'libusb'
  depends_on 'vtk'
  depends_on 'Sphinx' => :python
  depends_on 'zklapow/fuerte/roscpp_core' => :alt
  depends_on 'zklapow/fuerte/std_msgs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
