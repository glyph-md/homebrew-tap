class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://glyph-md.github.io"
  license "MIT"
  version "0.15.2"

  # url/sha256 must be defined at the top level so the formula parses on every
  # platform (otherwise macOS taps fail with "formula requires at least a URL").
  # `depends_on :linux` is what keeps this Linux-only at install time.
  if Hardware::CPU.arm?
    url "https://github.com/hamidfzm/glyph/releases/download/v0.15.2/Glyph_0.15.2_arm64.deb"
    sha256 "9b7ab58b84c71f025a4f99707383800569b5023a821387bf097876a121341a7f"
  else
    url "https://github.com/hamidfzm/glyph/releases/download/v0.15.2/Glyph_0.15.2_amd64.deb"
    sha256 "d8f326feb7bd914e101441bf16cea6eada50d740a4c6179934575e9bf881301f"
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
