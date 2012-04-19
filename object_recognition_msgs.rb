
require 'formula'

class ObjectRecognitionMsgs < Formula
  url 'git://github.com/wg-debs/object_recognition_msgs-release.git', {:using => :git, :tag => 'upstream/0.2.0'}
  homepage 'http://www.ros.org/wiki/object_recognition'
  version '0.2.0'

  depends_on 'ros/fuerte/genmsg' => :alt
  depends_on 'ros/fuerte/ecto_ros' => :alt
  depends_on 'ros/fuerte/ecto' => :alt
  depends_on 'ros/fuerte/catkin' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
