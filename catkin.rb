
require 'formula'

class Catkin < Formula
  url 'git://github.com/wg-debs/catkin-release.git', {:using => :git, :tag => 'upstream/0.4.5'}
  homepage 'http://www.ros.org/wiki/catkin'
  version '0.4.5'

  depends_on 'cmake'
  depends_on 'gtest'
  depends_on 'argparse' => :python
  depends_on 'EmPy' => :python
  depends_on 'nose' => :python
  depends_on 'rospkg' => :python
  depends_on 'setuptools' => :python
  depends_on LanguageModuleDependency.new :python, 'PyYAML', 'yaml'



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
