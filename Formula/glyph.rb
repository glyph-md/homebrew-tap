class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://glyph-md.github.io"
  license "MIT"
  version "0.21.0"

  # url/sha256 must be defined at the top level so the formula parses on every
  # platform (otherwise macOS taps fail with "formula requires at least a URL").
  # `depends_on :linux` is what keeps this Linux-only at install time.
  if Hardware::CPU.arm?
    url "https://github.com/hamidfzm/glyph/releases/download/v0.21.0/Glyph_0.21.0_arm64.deb"
    sha256 "40d9022ac9cbf03283e609dc598d48328e817afae4f4d4d8725b1bb89ebfd360"
  else
    url "https://github.com/hamidfzm/glyph/releases/download/v0.21.0/Glyph_0.21.0_amd64.deb"
    sha256 "b6654472a5fc906ec2e489d42c91ffaeb36f70ba1aead9458488b681a7afdcbc"
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
