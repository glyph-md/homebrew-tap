class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://github.com/hamidfzm/glyph"
  license "MIT"
  version "0.12.0"

  # url/sha256 must be defined at the top level so the formula parses on every
  # platform (otherwise macOS taps fail with "formula requires at least a URL").
  # `depends_on :linux` is what keeps this Linux-only at install time.
  if Hardware::CPU.arm?
    url "https://github.com/hamidfzm/glyph/releases/download/v0.12.0/Glyph_0.12.0_arm64.deb"
    sha256 "f01305c884219e114f08c095324d65aface304a3100179fec5c3671af57088e2"
  else
    url "https://github.com/hamidfzm/glyph/releases/download/v0.12.0/Glyph_0.12.0_amd64.deb"
    sha256 "f16f491090d9a96714e368ba2472ba9e8c247f629538f8efaae2e1bf67ae722c"
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
