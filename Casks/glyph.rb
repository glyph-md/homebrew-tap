cask "glyph" do
  version "0.17.0"
  sha256 "0d41a4a16b1c7b7abbb81d79053fac80b56231ceb59c4bf049b6673c7f85d8d1"

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
