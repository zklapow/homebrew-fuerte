
require 'formula'

class Genlisp < Formula
  url 'git://github.com/wg-debs/genlisp-release.git', {:using => :git, :tag => 'upstream/0.3.3'}
  homepage 'http://www.ros.org/wiki/roslisp'
  version '0.3.3'

  depends_on 'zklapow/fuerte/genmsg' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "mkdir #{prefix}/lib/python2.7/site-packages/"
    system "cd build && make install"
  end

end
