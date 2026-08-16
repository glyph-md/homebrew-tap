cask "glyph" do
  version "0.21.0"
  sha256 "869e39103b29f90036e7148d5af44c7163d9c199de7f60d0f9f902fe85600419"

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
