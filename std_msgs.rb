
require 'formula'

class StdMsgs < Formula
  url 'git://github.com/wg-debs/std_msgs-release.git', {:using => :git, :tag => 'upstream/0.4.10'}
  homepage 'http://www.ros.org/wiki/std_msgs'
  version '0.4.10'

  depends_on 'zklapow/fuerte/langs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
