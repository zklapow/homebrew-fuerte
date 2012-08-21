
require 'formula'

class EctoRos < Formula
  url 'git://github.com/wg-debs/ecto_ros-release.git', {:using => :git, :tag => 'upstream/0.3.12'}
  homepage 'http://ecto.willowgarage.com/recognition'
  version '0.3.12'

  depends_on 'zklapow/fuerte/common_msgs' => :alt
  depends_on 'zklapow/fuerte/ecto' => :alt
  depends_on 'eigen'
  depends_on 'opencv'
  depends_on 'zklapow/fuerte/ros_comm' => :alt
  depends_on 'zklapow/fuerte/std_msgs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
