cask "glyph" do
  version "0.27.0"
  sha256 "fe2868efda2bd684db4c563a3be30377c71c6d00fa2809a7c2259e152c8a2809"

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
