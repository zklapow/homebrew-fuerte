
require 'formula'

class ObjectRecognitionCore < Formula
  url 'git://github.com/wg-debs/object_recognition_core-release.git', {:using => :git, :tag => 'upstream/0.4.1'}
  homepage 'http://ecto.willowgarage.com/recognition'
  version '0.4.1'

  depends_on 'zklapow/fuerte/actionlib' => :alt
  depends_on 'boost'
  depends_on 'zklapow/fuerte/ecto' => :alt
  depends_on 'zklapow/fuerte/ecto_ros' => :alt
  depends_on 'zklapow/fuerte/ecto_image_pipeline' => :alt
  depends_on 'zklapow/fuerte/object_recognition_msgs' => :alt
  depends_on 'zklapow/fuerte/pcl' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
