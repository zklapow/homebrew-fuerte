require 'formula'

class Libyaml < Formula
  url 'http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz'
  homepage 'http://pyyaml.org/wiki/LibYAML'
  md5 '36c852831d02cf90508c29852361d01b'

  def options
    [
      ["--no-universal", "Build for 32 bit Intel only."],
    ]
  end

  def install
    args = ["--prefix=#{prefix}"]

    if not ARGV.build_no_universal?
      ENV['CFLAGS'] = "-arch i386 -arch x86_64"
      ENV['LDFLAGS'] = "-arch i386 -arch x86_64"
      args << "--disable-dependency-tracking"
    end

    system './configure', *args
    system "make install"
  end
end
