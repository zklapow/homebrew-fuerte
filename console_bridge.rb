
require 'formula'

class ConsoleBridge < Formula
  url 'git://github.com/wg-debs/console_bridge.git', {:using => :git, :tag => 'upstream/0.1.2'}
  homepage 'https://kforge.ros.org/projects/console_bridge/'
  version '0.1.2'

  depends_on 'boost'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
