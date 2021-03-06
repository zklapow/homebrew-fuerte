
require 'formula'

class ObjectRecognitionLinemod < Formula
  url 'git://github.com/wg-debs/object_recognition_linemod-release.git', {:using => :git, :tag => 'upstream/0.2.0'}
  homepage 'https://github.com/wg-perception/linemod'
  version '0.2.0'

  depends_on 'zklapow/fuerte/ecto' => :alt
  depends_on 'zklapow/fuerte/object_recognition_core' => :alt
  depends_on 'opencv'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
