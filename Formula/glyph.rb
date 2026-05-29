class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://github.com/hamidfzm/glyph"
  license "MIT"
  version "0.8.1"

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/hamidfzm/glyph/releases/download/v0.8.1/Glyph_0.8.1_amd64.deb"
      sha256 "b9f53d160fa179292a229ded6d7fc8c0a6fd7389a9d3254b64d244d201053bbc"
    end
    if Hardware::CPU.arm?
      url "https://github.com/hamidfzm/glyph/releases/download/v0.8.1/Glyph_0.8.1_arm64.deb"
      sha256 "b8a3fba7af8ef46d200719be6c03f5fb0ef2baeab1305c1659d8ef5c25b1d9e0"
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
