cask "glyph" do
  version "0.5.0"
  sha256 "251f5929df00543d75f36e6e4377ed33a9096a52f0967d15407ee657e4c2e998"

  url "https://github.com/hamidfzm/glyph/releases/download/v#{version}/Glyph_#{version}_universal.dmg"
  name "Glyph"
  desc "Cross-platform markdown viewer"
  homepage "https://github.com/hamidfzm/glyph"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Glyph.app"

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
