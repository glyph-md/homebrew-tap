cask "glyph" do
  version "0.18.0"
  sha256 "34918d50ddcb7ebd09f7c2e6c55e5bf3decdb2e85a20ce700ed5a37ca31005e1"

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
