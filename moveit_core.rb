
require 'formula'

class MoveitCore < Formula
  url 'git://github.com/wg-debs/moveit_core-release.git', {:using => :git, :tag => 'upstream/0.1.3'}
  homepage 'http://moveit.ros.org'
  version '0.1.3'

  depends_on 'zklapow/fuerte/common_msgs' => :alt
  depends_on 'zklapow/fuerte/console_bridge' => :alt
  depends_on 'zklapow/fuerte/rosconsole_bridge' => :alt
  depends_on 'zklapow/fuerte/random_numbers' => :alt
  depends_on 'zklapow/fuerte/shape_tools' => :alt
  depends_on 'zklapow/fuerte/moveit_msgs' => :alt
  depends_on 'zklapow/fuerte/octomap' => :alt
  depends_on 'zklapow/fuerte/ompl' => :alt
  depends_on 'zklapow/fuerte/sbpl' => :alt
  depends_on 'zklapow/fuerte/urdfdom' => :alt
  depends_on 'zklapow/fuerte/srdfdom' => :alt
  depends_on 'qhull'
  depends_on 'eigen'
  depends_on 'boost'
  depends_on 'assimp'
  depends_on 'zklapow/fuerte/libccd' => :alt
  depends_on 'zklapow/fuerte/flann' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
