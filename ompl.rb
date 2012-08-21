
require 'formula'

class Ompl < Formula
  url 'git://github.com/wg-debs/ompl.git', {:using => :git, :tag => 'upstream/0.11.1002045'}
  homepage 'http://ompl.kavrakilab.org'
  version '0.11.1002045'

  depends_on 'boost'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
