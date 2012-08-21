
require 'formula'

class ShapeTools < Formula
  url 'git://github.com/wg-debs/shape_tools-release.git', {:using => :git, :tag => 'upstream/0.1.8'}
  homepage 'http://www.ros.org/wiki/shape_tools'
  version '0.1.8'

  depends_on 'zklapow/fuerte/common_msgs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
