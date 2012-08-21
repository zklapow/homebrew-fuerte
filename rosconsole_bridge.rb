
require 'formula'

class RosconsoleBridge < Formula
  url 'git://github.com/wg-debs/rosconsole_bridge-release.git', {:using => :git, :tag => 'upstream/0.1.0'}
  homepage 'http://ros.org/wiki/random_numbers'
  version '0.1.0'

  depends_on 'zklapow/fuerte/console_bridge' => :alt
  depends_on 'zklapow/fuerte/ros_comm' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
