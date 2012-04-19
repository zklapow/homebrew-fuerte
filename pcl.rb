
require 'formula'

class Pcl < Formula
  url 'git://github.com/wg-debs/pcl.git', {:using => :git, :tag => 'upstream/1.5.2'}
  homepage 'http://pointclouds.org/'
  version '1.5.2'

  depends_on 'Sphinx' => :python
  depends_on 'cmake'
  depends_on 'eigen'
  depends_on 'mysql'
  depends_on 'qhull'
  depends_on 'vtk'
  depends_on 'libusb'
  depends_on 'ros/fuerte/flann' => :alt
  depends_on 'boost'
  depends_on 'ros/fuerte/common_msgs' => :alt


  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end
end
