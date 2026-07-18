class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://glyph-md.github.io"
  license "MIT"
  version "0.17.1"

  # url/sha256 must be defined at the top level so the formula parses on every
  # platform (otherwise macOS taps fail with "formula requires at least a URL").
  # `depends_on :linux` is what keeps this Linux-only at install time.
  if Hardware::CPU.arm?
    url "https://github.com/hamidfzm/glyph/releases/download/v0.17.1/Glyph_0.17.1_arm64.deb"
    sha256 "71690dd8a5b4a9b38926681acb9b115524af4cebefc29e037674503115835b92"
  else
    url "https://github.com/hamidfzm/glyph/releases/download/v0.17.1/Glyph_0.17.1_amd64.deb"
    sha256 "34a44ff3ff37ccaa1408b7797600daa6bcc05a835fd6b8a324bd8e25570dac7b"
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
