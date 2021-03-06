
require 'formula'

class EctoPcl < Formula
  url 'git://github.com/wg-debs/ecto_pcl-release.git', {:using => :git, :tag => 'upstream/0.3.5'}
  homepage 'http://ecto.willowgarage.com'
  version '0.3.5'

  depends_on 'boost'
  depends_on 'zklapow/fuerte/ecto' => :alt
  depends_on 'zklapow/fuerte/ecto_ros' => :alt
  depends_on 'zklapow/fuerte/pcl' => :alt



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
