
require 'formula'

class Langs-dev < Formula
  url 'git://github.com/wg-debs/langs-dev-release.git', {:using => :git, :tag => 'upstream/0.1.3'}
  homepage 'http://www.ros.org'
  version '0.1.3'

  depends_on 'zklapow/fuerte/catkin' => :alt
  depends_on 'zklapow/fuerte/gencpp' => :alt
  depends_on 'zklapow/fuerte/genlisp' => :alt
  depends_on 'zklapow/fuerte/genpy' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
