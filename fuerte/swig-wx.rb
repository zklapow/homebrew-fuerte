require 'formula'

class Swig-wx < Formula
  url 'https://github.com/wg-debs/swig-wx/tarball/debian/ros_fuerte_1.3.29_oneiric'
  homepage 'http://ros.org/wiki/wxswig'
  md5 'edd2f143ff51295f9ffa7e1f9ecab358'
  version '1.3.29'

  def install
    ENV.universal_binary
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end