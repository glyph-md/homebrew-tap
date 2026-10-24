class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://glyph-md.github.io"
  license "MIT"
  version "0.27.0"

  # url/sha256 must be defined at the top level so the formula parses on every
  # platform (otherwise macOS taps fail with "formula requires at least a URL").
  # `depends_on :linux` is what keeps this Linux-only at install time.
  if Hardware::CPU.arm?
    url "https://github.com/hamidfzm/glyph/releases/download/v0.27.0/Glyph_0.27.0_arm64.deb"
    sha256 "6a9060d28cc0db54783975ed0d25c434bb903724b1232d2eec9b2f8290d67dd8"
  else
    url "https://github.com/hamidfzm/glyph/releases/download/v0.27.0/Glyph_0.27.0_amd64.deb"
    sha256 "96aec9593e8ec482df8f1623a8c7f42bd4f7fe25b2ceb84ed3f13d3c26a28f4e"
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
