
require 'formula'

class EctoImagePipeline < Formula
  url 'git://github.com/wg-debs/ecto_image_pipeline-release.git', {:using => :git, :tag => 'upstream/0.4.1'}
  homepage 'http://ecto.willowgarage.com'
  version '0.4.1'

  depends_on 'boost'
  depends_on 'zklapow/fuerte/ecto' => :alt
  depends_on 'zklapow/fuerte/ecto_opencv' => :alt
  depends_on 'zklapow/fuerte/libg2o' => :alt
  depends_on 'opencv'
  depends_on 'zklapow/fuerte/pcl' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
