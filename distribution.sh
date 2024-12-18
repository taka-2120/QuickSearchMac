APP_NAME="QuickSearch"
CASK_FILE_PATH="./Casks/quick-search.rb"
DMG_FILE_PATH="./output/$APP_NAME.dmg"

if ! [ -d "output" ]; then
  mkdir output
fi

if [ -f "$DMG_FILE_PATH" ]; then
  rm $DMG_FILE_PATH
fi

hdiutil create -srcFolder . -o $DMG_FILE_PATH

NEW_SHA256=$(shasum -a 256 $DMG_FILE_PATH)
NEW_SHA256=$(echo $NEW_SHA256 | cut -d ' ' -f 1)

sed -i '' "s/sha256.*/sha256 \"$NEW_SHA256\"/g" $CASK_FILE_PATH

echo "Successfully replaced SHA256 code"
