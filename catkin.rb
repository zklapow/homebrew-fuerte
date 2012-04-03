require 'formula'

class Catkin < Formula
  url 'https://github.com/willowgarage/catkin/tarball/0.3.26'
  homepage 'http://people.willowgarage.com/straszheim/catkin-dev/catkin/'
  md5 'af093780acc300f68b52e753f2743105'
  version '0.3.26'

  depends_on 'cmake' => :build
  depends_on 'nose' => :python
  depends_on 'em' => :python

  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end
end
