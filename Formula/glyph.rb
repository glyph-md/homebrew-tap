class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://github.com/hamidfzm/glyph"
  license "MIT"
  version "0.11.0"

  # url/sha256 must be defined at the top level so the formula parses on every
  # platform (otherwise macOS taps fail with "formula requires at least a URL").
  # `depends_on :linux` is what keeps this Linux-only at install time.
  if Hardware::CPU.arm?
    url "https://github.com/hamidfzm/glyph/releases/download/v0.11.0/Glyph_0.11.0_arm64.deb"
    sha256 "ff38e815581bf13ecf8b8dfb5a0d2ca5271b2e1a175ad0002837a2479016c3c5"
  else
    url "https://github.com/hamidfzm/glyph/releases/download/v0.11.0/Glyph_0.11.0_amd64.deb"
    sha256 "35c7790c8acc8507a1b9ce7bd90b0d6eadcb740c7568e7b2d68e5d13ccc363e2"
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
