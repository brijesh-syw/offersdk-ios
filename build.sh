#! /bin/sh

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#content=$(<version.txt)
content=1.0
bundle_version="$content"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "${DIR}"

xcodebuild archive -workspace 'OfferSDK.xcodeproj/project.xcworkspace' \
-scheme OfferSDK \
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath "./build/$content/OfferSDK.framework-iphoneos.xcarchive" \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
DEBUG_INFORMATION_FORMAT=dwarf-with-dsym

xcodebuild archive -workspace 'OfferSDK.xcodeproj/project.xcworkspace' \
-scheme OfferSDK \
-configuration Release \
-destination 'generic/platform=iOS Simulator' \
-archivePath "./build/$content/OfferSDK.framework-iphonesimulator.xcarchive" \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
DEBUG_INFORMATION_FORMAT=dwarf-with-dsym


# Inject version metadata into each Info.plist
for PLATFORM in "iphoneos" "iphonesimulator"; do
  plist="./build/$content/OfferSDK.framework-$PLATFORM.xcarchive/Products/Library/Frameworks/OfferSDK.framework/Info.plist"

  /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $bundle_version" "$plist" 2>/dev/null \
  || /usr/libexec/PlistBuddy -c "Add :CFBundleVersion string $bundle_version" "$plist"

done

xcodebuild -create-xcframework \
-framework "./build/$content/OfferSDK.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/OfferSDK.framework" \
-debug-symbols "${PWD}/./build/$content/OfferSDK.framework-iphonesimulator.xcarchive/dSYMs/OfferSDK.framework.dSYM" \
-framework "./build/$content/OfferSDK.framework-iphoneos.xcarchive/Products/Library/Frameworks/OfferSDK.framework" \
-debug-symbols "${PWD}/./build/$content/OfferSDK.framework-iphoneos.xcarchive/dSYMs/OfferSDK.framework.dSYM" \
-output "./build/$content/OfferSDK.xcframework"

# Inject version metadata into top-level Info.plist in the XCFramework
top_level_plist="./build/$content/OfferSDK.xcframework/Info.plist"

if [ -f "$top_level_plist" ]; then
  /usr/libexec/PlistBuddy -c "Add :CFBundleVersion string $bundle_version" "$top_level_plist" 2>/dev/null \
  || /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $bundle_version" "$top_level_plist"
fi

exit 0
