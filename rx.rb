
require 'formula'

class Rx < Formula
  url 'git://github.com/wg-debs/rx-release.git', {:using => :git, :tag => 'upstream/1.8.9'}
  homepage 'http://www.ros.org/wiki/rx'
  version '1.8.9'

  depends_on 'graphviz'
  depends_on 'matplotlib' => :python
  depends_on 'zklapow/fuerte/ros' => :alt
  depends_on 'zklapow/fuerte/ros_comm' => :alt
  depends_on 'zklapow/fuerte/rospack' => :alt
  depends_on 'ros/fuerte/swig-wx' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
