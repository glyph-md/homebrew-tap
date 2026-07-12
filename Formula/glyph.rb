class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://glyph-md.github.io"
  license "MIT"
  version "0.16.0"

  # url/sha256 must be defined at the top level so the formula parses on every
  # platform (otherwise macOS taps fail with "formula requires at least a URL").
  # `depends_on :linux` is what keeps this Linux-only at install time.
  if Hardware::CPU.arm?
    url "https://github.com/hamidfzm/glyph/releases/download/v0.16.0/Glyph_0.16.0_arm64.deb"
    sha256 "f35514bc184af413b920c97748c3348985e1a389b3aae8458782215a110e1899"
  else
    url "https://github.com/hamidfzm/glyph/releases/download/v0.16.0/Glyph_0.16.0_amd64.deb"
    sha256 "b34a99c36e7f942957231af895c478a1db0227b4dd92d05708993ebb1e69b4e1"
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
