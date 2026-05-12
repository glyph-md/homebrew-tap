class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://github.com/hamidfzm/glyph"
  license "MIT"
  version "0.6.0"

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/hamidfzm/glyph/releases/download/v0.6.0/Glyph_0.6.0_amd64.deb"
      sha256 "8f2e4e17dbc5393003f38e629ffcf6fa3460d47739eccfe402dce02ccc805653"
    end
    if Hardware::CPU.arm?
      url "https://github.com/hamidfzm/glyph/releases/download/v0.6.0/Glyph_0.6.0_arm64.deb"
      sha256 "d53fdd1ba047a0c728863b87a5b995b84ba22a0fd98dc5555d194f907f92932d"
    end
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
