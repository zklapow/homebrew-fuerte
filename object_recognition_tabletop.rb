
require 'formula'

class ObjectRecognitionTabletop < Formula
  url 'git://github.com/wg-debs/object_recognition_tabletop-release.git', {:using => :git, :tag => 'upstream/0.2.6'}
  homepage 'http://ecto.willowgarage.com'
  version '0.2.6'

  depends_on 'zklapow/fuerte/ecto' => :alt
  depends_on 'zklapow/fuerte/ecto_pcl' => :alt
  depends_on 'zklapow/fuerte/object_recognition_core' => :alt
  depends_on 'zklapow/fuerte/object_recognition_msgs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
