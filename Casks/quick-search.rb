cask "quick-search" do
  version "1.0.0"  
  sha256 "a785cb75827f0c6e1c71b9a7ecf022894360d2fc6476b2938612cd387121a1f5" 

  url "https://your-hosting-url.com/quick-search-#{version}.dmg"
  name "QuickSearch"
  desc "Search on Web Quickly"
  homepage "https://github.com/taka-2120/QuickSerachMac" 

  app "QuickSearch.app"

  # zap trash: [
  #   "~/Library/Preferences/com.your-app.plist",
  #   "~/Library/Application Support/YourApp",
  # ]
end