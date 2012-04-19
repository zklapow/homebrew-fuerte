
require 'formula'

class Langs < Formula
  url 'git://github.com/wg-debs/langs.git', {:using => :git, :tag => 'upstream/0.3.1'}
  homepage 'http://www.ros.org'
  version '0.3.1'

  depends_on 'ros/fuerte/genlisp' => :alt
  depends_on 'ros/fuerte/genpy' => :alt
  depends_on 'ros/fuerte/genmsg' => :alt
  depends_on 'ros/fuerte/catkin' => :alt
  depends_on 'ros/fuerte/gencpp' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
