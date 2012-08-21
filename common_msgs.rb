
require 'formula'

class CommonMsgs < Formula
  url 'git://github.com/wg-debs/common_msgs-release.git', {:using => :git, :tag => 'upstream/1.8.13'}
  homepage 'http://www.ros.org/wiki/common_msgs'
  version '1.8.13'

  depends_on 'boost'
  depends_on 'zklapow/fuerte/langs' => :alt
  depends_on 'zklapow/fuerte/std_msgs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
