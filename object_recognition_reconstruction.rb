
require 'formula'

class ObjectRecognitionReconstruction < Formula
  url 'git://github.com/wg-debs/object_recognition_reconstruction-release.git', {:using => :git, :tag => 'upstream/0.2.8'}
  homepage 'http://ecto.willowgarage.com/recognition'
  version '0.2.8'

  depends_on 'zklapow/fuerte/ecto' => :alt
  depends_on 'zklapow/fuerte/ecto_image_pipeline' => :alt
  depends_on 'zklapow/fuerte/ecto_pcl' => :alt
  depends_on 'zklapow/fuerte/object_recognition_core' => :alt
  depends_on 'opencv'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
