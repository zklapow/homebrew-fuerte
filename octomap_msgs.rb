
require 'formula'

class OctomapMsgs < Formula
  url 'git://github.com/wg-debs/octomap_msgs-release.git', {:using => :git, :tag => 'upstream/0.1.4'}
  homepage 'http://ros.org/wiki/octomap_msgs'
  version '0.1.4'

  depends_on 'zklapow/fuerte/common_msgs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
