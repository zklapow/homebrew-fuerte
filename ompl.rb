
require 'formula'

class Ompl < Formula
  url 'git://github.com/wg-debs/ompl.git', {:using => :git, :tag => 'upstream/0.10.2001850'}
  homepage 'http://ompl.kavrakilab.org'
  version '0.10.2001850'

  depends_on 'boost'
  depends_on 'gtest'
  depends_on 'cmake'


  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end
end
