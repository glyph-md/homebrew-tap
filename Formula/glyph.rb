class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://glyph-md.github.io"
  license "MIT"
  version "0.15.1"

  # url/sha256 must be defined at the top level so the formula parses on every
  # platform (otherwise macOS taps fail with "formula requires at least a URL").
  # `depends_on :linux` is what keeps this Linux-only at install time.
  if Hardware::CPU.arm?
    url "https://github.com/hamidfzm/glyph/releases/download/v0.15.1/Glyph_0.15.1_arm64.deb"
    sha256 "60f7a10d6e2ed685857beb4d97cdef7c68c614f5257a1353c88ac793ea7343db"
  else
    url "https://github.com/hamidfzm/glyph/releases/download/v0.15.1/Glyph_0.15.1_amd64.deb"
    sha256 "78361e30a3638b382dd3e26c85d9dfbe513f9b2afebce6cd1f7cab819b8bc01e"
  end

  depends_on :linux
  depends_on "webkit2gtk"
  depends_on "gtk+3"

  def install
    # Extract binary from deb
    system "ar", "x", cached_download
    system "tar", "xf", "data.tar.gz"
    bin.install Dir["usr/bin/*"]
    share.install Dir["usr/share/*"]
  end

  test do
    assert_match "glyph", shell_output("#{bin}/glyph --version", 1)
  end
end
