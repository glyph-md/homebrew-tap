class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://glyph-md.github.io"
  license "MIT"
  version "0.17.2"

  # url/sha256 must be defined at the top level so the formula parses on every
  # platform (otherwise macOS taps fail with "formula requires at least a URL").
  # `depends_on :linux` is what keeps this Linux-only at install time.
  if Hardware::CPU.arm?
    url "https://github.com/hamidfzm/glyph/releases/download/v0.17.2/Glyph_0.17.2_arm64.deb"
    sha256 "f51abe20cd8bb7c8aead6c468582b41b1a899348498988344c13de76af7bb7e0"
  else
    url "https://github.com/hamidfzm/glyph/releases/download/v0.17.2/Glyph_0.17.2_amd64.deb"
    sha256 "795a5dfa54c4c5fadcf1271ea45a084d13220568a65c1baff1c1d67f3f5ed171"
  end

  depends_on :linux

  def install
    # Extract binary from deb
    system "ar", "x", cached_download
    system "tar", "xf", "data.tar.gz"
    bin.install Dir["usr/bin/*"]
    share.install Dir["usr/share/*"]
  end

  def caveats
    <<~EOS
      Glyph links against the system WebKitGTK and GTK 3 libraries, which
      Homebrew does not provide. Install them with your distro's package
      manager, e.g. on Debian/Ubuntu:
        sudo apt install libwebkit2gtk-4.1-0 libgtk-3-0
    EOS
  end

  test do
    assert_match "glyph", shell_output("#{bin}/glyph --version", 1)
  end
end
