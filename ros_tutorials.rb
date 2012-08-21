
require 'formula'

class RosTutorials < Formula
  url 'git://github.com/wg-debs/ros_tutorials-release.git', {:using => :git, :tag => 'upstream/0.2.19'}
  homepage 'http://www.ros.org/wiki/ros_tutorials'
  version '0.2.19'

  depends_on 'zklapow/fuerte/langs' => :alt
  depends_on 'qt'
  depends_on 'zklapow/fuerte/ros_comm' => :alt
  depends_on 'zklapow/fuerte/std_msgs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
