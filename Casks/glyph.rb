cask "glyph" do
  version "0.23.0"
  sha256 "d44bccbc1cc8c026d601f1d5d314edec20a85f82256727b181a72beb6308dc3c"

  url "https://github.com/hamidfzm/glyph/releases/download/v#{version}/Glyph_#{version}_universal.dmg"
  name "Glyph"
  desc "Cross-platform markdown viewer"
  homepage "https://glyph-md.github.io"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Glyph.app"
  binary "#{appdir}/Glyph.app/Contents/MacOS/Glyph", target: "glyph"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Glyph.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/com.hamidfzm.glyph",
    "~/Library/Caches/com.hamidfzm.glyph",
    "~/Library/Preferences/com.hamidfzm.glyph.plist",
  ]
end
