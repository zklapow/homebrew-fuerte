
require 'formula'

class Genlisp < Formula
  url 'git://github.com/wg-debs/genlisp-release.git', {:using => :git, :tag => 'upstream/0.3.0'}
  homepage 'http://www.ros.org/wiki/roslisp'
  version '0.3.0'

  depends_on 'ros/fuerte/genmsg' => :alt
  depends_on 'ros/fuerte/catkin' => :alt


  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end
end
