require 'formula'

class Catkin < Formula
  url 'https://github.com/willowgarage/catkin/tarball/0.3.19'
  homepage 'http://people.willowgarage.com/straszheim/catkin-dev/catkin/'
  md5 'b0a32f50d474680feb7ad4bc01012af8'
  version '0.3.19'

  depends_on 'swig-wx'
  depends_on 'qt'
  depends_on 'cmake'
  depends_on 'rosinstall' <= python

  def install
    ENV.universal_binary
    system "cmake . #{std_cmake_parameters}"
    system "make"
    system "make install"
  end
end