
require 'formula'

class EctoImagePipeline < Formula
  url 'git://github.com/wg-debs/ecto_image_pipeline-release.git', {:using => :git, :tag => 'upstream/0.3.2'}
  homepage 'http://ecto.willowgarage.com'
  version '0.3.2'

  depends_on 'ros/fuerte/catkin' => :alt
  depends_on 'opencv'
  depends_on 'ros/fuerte/pcl' => :alt
  depends_on 'ros/fuerte/libg2o' => :alt
  depends_on 'ros/fuerte/ecto' => :alt
  depends_on 'boost'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
