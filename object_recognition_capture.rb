
require 'formula'

class ObjectRecognitionCapture < Formula
  url 'git://github.com/wg-debs/object_recognition_capture-release.git', {:using => :git, :tag => 'upstream/0.2.10'}
  homepage 'http://ecto.willowgarage.com/recognition'
  version '0.2.10'

  depends_on 'boost'
  depends_on 'zklapow/fuerte/ecto' => :alt
  depends_on 'zklapow/fuerte/ecto_image_pipeline' => :alt
  depends_on 'zklapow/fuerte/ecto_opencv' => :alt
  depends_on 'zklapow/fuerte/ecto_openni' => :alt
  depends_on 'zklapow/fuerte/object_recognition_core' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
