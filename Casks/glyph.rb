cask "glyph" do
  version "0.15.0"
  sha256 "842a2b8b69aec17599aa4719336b2f7470a75efe4739a107835470b45144668f"

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
