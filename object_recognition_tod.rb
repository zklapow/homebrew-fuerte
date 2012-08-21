
require 'formula'

class ObjectRecognitionTod < Formula
  url 'git://github.com/wg-debs/object_recognition_tod-release.git', {:using => :git, :tag => 'upstream/0.4.2'}
  homepage 'http://ecto.willowgarage.com'
  version '0.4.2'

  depends_on 'zklapow/fuerte/ecto' => :alt
  depends_on 'zklapow/fuerte/ecto_opencv' => :alt
  depends_on 'zklapow/fuerte/object_recognition_core' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
