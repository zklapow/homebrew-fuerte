
require 'formula'

class MoveitMsgs < Formula
  url 'git://github.com/wg-debs/moveit_msgs-release.git', {:using => :git, :tag => 'upstream/0.2.4'}
  homepage 'http://moveit.ros.org'
  version '0.2.4'

  depends_on 'zklapow/fuerte/common_msgs' => :alt
  depends_on 'zklapow/fuerte/octomap_msgs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
