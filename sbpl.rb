
require 'formula'

class Sbpl < Formula
  url 'git://github.com/wg-debs/sbpl.git', {:using => :git, :tag => 'upstream/1.0.5'}
  homepage 'http://www.ros.org'
  version '1.0.5'

  depends_on 'ros/fuerte/catkin' => :alt
  depends_on 'cmake'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
