class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://glyph-md.github.io"
  license "MIT"
  version "0.15.0"

  # url/sha256 must be defined at the top level so the formula parses on every
  # platform (otherwise macOS taps fail with "formula requires at least a URL").
  # `depends_on :linux` is what keeps this Linux-only at install time.
  if Hardware::CPU.arm?
    url "https://github.com/hamidfzm/glyph/releases/download/v0.15.0/Glyph_0.15.0_arm64.deb"
    sha256 "1a6085017d16e7985e5c46fc2878d6278dcc151f2240d3928a4fce9bc69e57a0"
  else
    url "https://github.com/hamidfzm/glyph/releases/download/v0.15.0/Glyph_0.15.0_amd64.deb"
    sha256 "9b7e924e5c5ba5b8ff7e37bca8f5c495f654f5eb60c67e780f3d41ead99d24b2"
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
