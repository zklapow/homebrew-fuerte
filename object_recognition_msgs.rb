
require 'formula'

class ObjectRecognitionMsgs < Formula
  url 'git://github.com/wg-debs/object_recognition_msgs-release.git', {:using => :git, :tag => 'upstream/0.3.3'}
  homepage 'http://www.ros.org/wiki/object_recognition'
  version '0.3.3'

  depends_on 'zklapow/fuerte/common_msgs' => :alt
  depends_on 'zklapow/fuerte/ecto' => :alt
  depends_on 'zklapow/fuerte/ecto_ros' => :alt
  depends_on 'zklapow/fuerte/langs' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
