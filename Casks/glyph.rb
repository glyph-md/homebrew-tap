cask "glyph" do
  version "0.26.0"
  sha256 "4d80151e9696f514fd6afc635db58131974012c18bd694d0029ad8490cfa64dc"

  url "https://github.com/hamidfzm/glyph/releases/download/v#{version}/Glyph_#{version}_universal.dmg"
  name "Glyph"
  desc "Cross-platform markdown viewer"
  homepage "https://glyph-md.github.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Glyph.app"
  binary "#{appdir}/Glyph.app/Contents/MacOS/Glyph", target: "glyph"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/Glyph.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.hamidfzm.glyph",
    "~/Library/Caches/com.hamidfzm.glyph",
    "~/Library/Preferences/com.hamidfzm.glyph.plist",
  ]
end
