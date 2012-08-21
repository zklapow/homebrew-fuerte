
require 'formula'

class Octomap < Formula
  url 'git://github.com/wg-debs/octomap-release.git', {:using => :git, :tag => 'upstream/1.4.91'}
  homepage 'http://octomap.sf.net'
  version '1.4.91'




  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
