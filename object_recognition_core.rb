
require 'formula'

class ObjectRecognitionCore < Formula
  url 'git://github.com/wg-debs/object_recognition_core-release.git', {:using => :git, :tag => 'upstream/0.3.0'}
  homepage 'http://ecto.willowgarage.com/recognition'
  version '0.3.0'

  depends_on 'ros/fuerte/ecto_ros' => :alt
  depends_on 'ros/fuerte/catkin' => :alt
  depends_on 'ros/fuerte/actionlib' => :alt
  depends_on 'ros/fuerte/object_recognition_msgs' => :alt
  depends_on 'ros/fuerte/pcl' => :alt
  depends_on 'ros/fuerte/ecto' => :alt
  depends_on 'boost'
  depends_on 'ros/fuerte/ecto_image_pipeline' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
