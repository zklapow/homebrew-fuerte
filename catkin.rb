
require 'formula'

class Catkin < Formula
  url 'git://github.com/wg-debs/catkin.git', {:using => :git, :tag => 'upstream/0.3.28'}
  homepage 'http://www.ros.org/wiki/catkin'
  version '0.3.28'

  depends_on LanguageModuleDependency.new :python, PyYAML, yaml
  depends_on 'setuptools' => :python
  depends_on 'cmake'
  depends_on 'EmPy' => :python
  depends_on 'argparse' => :python
  depends_on 'gtest'
  depends_on 'nose' => :python



  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end
