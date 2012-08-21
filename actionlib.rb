
require 'formula'

class Actionlib < Formula
  url 'git://github.com/wg-debs/actionlib-release.git', {:using => :git, :tag => 'upstream/1.8.7'}
  homepage 'http://www.ros.org/wiki/actionlib'
  version '1.8.7'

  depends_on 'zklapow/fuerte/common_msgs' => :alt
  depends_on 'zklapow/fuerte/langs' => :alt
  depends_on 'zklapow/fuerte/ros' => :alt
  depends_on 'zklapow/fuerte/ros_comm' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
