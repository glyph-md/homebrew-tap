class Glyph < Formula
  desc "Cross-platform markdown viewer"
  homepage "https://glyph-md.github.io"
  license "MIT"
  version "0.19.0"

  # url/sha256 must be defined at the top level so the formula parses on every
  # platform (otherwise macOS taps fail with "formula requires at least a URL").
  # `depends_on :linux` is what keeps this Linux-only at install time.
  if Hardware::CPU.arm?
    url "https://github.com/hamidfzm/glyph/releases/download/v0.19.0/Glyph_0.19.0_arm64.deb"
    sha256 "9cc7a77bc8bb58dae886b150eee0e1b73059719e296ac4d9bffeb9b1981b1681"
  else
    url "https://github.com/hamidfzm/glyph/releases/download/v0.19.0/Glyph_0.19.0_amd64.deb"
    sha256 "f50051d50968c6b17640a05ca06491b18f38dac0bdc7e9e778d4f4364d6c60bc"
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
