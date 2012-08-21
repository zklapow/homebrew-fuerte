
require 'formula'

class Sbpl < Formula
  url 'git://github.com/wg-debs/sbpl.git', {:using => :git, :tag => 'upstream/1.1.2'}
  homepage 'http://www.ros.org'
  version '1.1.2'

  depends_on 'zklapow/fuerte/ros_comm' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
