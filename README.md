# dotmac - Quick setup Macbook Pro config

## General UI/UX

### Increase window resize speed for Cocoa applications
```bash
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
```

### Expand save panel by default
```bash
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
```

### Expand print panel by default
```bash
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
```

### Save to disk (not to iCloud) by default
```bash
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
```

### Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
```bash
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
```

### Check for software updates daily, not just once per week
```bash
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
```

###############################################################################
### SSD-specific tweaks                                                         #
###############################################################################

### Disable local Time Machine snapshots
```bash
sudo tmutil disablelocal
```

### Disable hibernation (speeds up entering sleep mode)
```bash
sudo pmset -a hibernatemode 0
```

### Remove the sleep image file to save disk space
```bash
sudo rm /private/var/vm/sleepimage
```

### Create a zero-byte file instead…
```bash
sudo touch /private/var/vm/sleepimage
```

### …and make sure it can’t be rewritten
```bash
sudo chflags uchg /private/var/vm/sleepimage
```

### Disable the sudden motion sensor as it’s not useful for SSDs
```bash
sudo pmset -a sms 0
```

### Set standby delay to 24 hours (default is 1 hour)
```bash
sudo pmset -a standbydelay 86400
```

###############################################################################
### Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

### Set a blazingly fast keyboard repeat rate
```bash
defaults write NSGlobalDomain KeyRepeat -int 0
```

### Trackpad: enable tap to click for this user and for the login screen
```bash
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
```

### Enable full keyboard access for all controls
### (e.g. enable Tab in modal dialogs)
```bash
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
```

###############################################################################
### Screen                                                                      #
###############################################################################

### Save screenshots to the desktop
```bash
mkdiir "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"
```

### Finder: show all filename extensions
```bash
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
```

### Finder: show status bar
```bash
defaults write com.apple.finder ShowStatusBar -bool true
```

### Finder: show path bar
```bash
defaults write com.apple.finder ShowPathbar -bool true
```

### Display full POSIX path as Finder window title
```bash
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
```

### Disable the warning when changing a file extension
```bash
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
```

### Avoid creating .DS_Store files on network volumes
```bash
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
```

### Enable snap-to-grid for icons on the desktop and in other icon views
```bash
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
```

### Increase grid spacing for icons on the desktop and in other icon views
```bash
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
```

### Use list view in all Finder windows by default
### Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
```bash
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
```

### Show the ~/Library folder
```bash
chflags nohidden ~/Library
```

### Wipe all (default) app icons from the Dock
### This is only really useful when setting up a new Mac, or if you don’t use
### the Dock to launch apps.
```bash
defaults write com.apple.dock persistent-apps -array
```

### Disable Dashboard
```bash
#defaults write com.apple.dashboard mcx-disabled -bool true
```

### Don’t show Dashboard as a Space
```bash
#defaults write com.apple.dock dashboard-in-overlay -bool true
```

### Don’t automatically rearrange Spaces based on most recent use
```bash
defaults write com.apple.dock mru-spaces -bool false
```

### Remove the auto-hiding Dock delay
```bash
defaults write com.apple.dock autohide-delay -float 0
```

### Remove the animation when hiding/showing the Dock
```bash
defaults write com.apple.dock autohide-time-modifier -float 0
```

### Automatically hide and show the Dock
```bash
defaults write com.apple.dock autohide -bool true
```

###############################################################################
### Safari & WebKit                                                             #
###############################################################################

### Privacy: don’t send search queries to Apple
```bash
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
```

### Show the full URL in the address bar (note: this still hides the scheme)
```bash
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
```

### Set Safari’s home page to `about:blank` for faster loading
```bash
defaults write com.apple.Safari HomePage -string "about:blank"
```

### Prevent Safari from opening ‘safe’ files automatically after downloading
```bash
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
```

### Hide Safari’s bookmarks bar by default
```bash
defaults write com.apple.Safari ShowFavoritesBar -bool false
```

### Hide Safari’s sidebar in Top Sites
```bash
defaults write com.apple.Safari ShowSidebarInTopSites -bool false
```

###############################################################################
### Spotlight                                                                   #
###############################################################################

### Disable Spotlight indexing for any volume that gets mounted and has not yet
### been indexed before.
### Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
```bash
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
```

###############################################################################
### Terminal & iTerm 2                                                          #
###############################################################################

### Only use UTF-8 in Terminal.app
```bash
defaults write com.apple.terminal StringEncodings -array 4
```

###############################################################################
### Time Machine                                                                #
###############################################################################

### Prevent Time Machine from prompting to use new hard drives as backup volume
```bash
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
```

### Disable local Time Machine backups
```bash
hash tmutil &> /dev/null && sudo tmutil disablelocal
```

###############################################################################
### Activity Monitor                                                            #
###############################################################################

### Show the main window when launching Activity Monitor
```bash
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
```

### Visualize CPU usage in the Activity Monitor Dock icon
```bash
defaults write com.apple.ActivityMonitor IconType -int 5
```

### Show all processes in Activity Monitor
```bash
defaults write com.apple.ActivityMonitor ShowCategory -int 0
```

### Sort Activity Monitor results by CPU usage
```bash
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
```

###############################################################################
### Transmission.app                                                            #
###############################################################################

### Use `~/Download/Torrents` to store incomplete downloads
```bash
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Download/Torrents"
```

### Don’t prompt for confirmation before downloading
```bash
defaults write org.m0k.transmission DownloadAsk -bool false
```

### Hide the donate message
```bash
defaults write org.m0k.transmission WarningDonate -bool false
```

### Hide the legal disclaimer
```bash
defaults write org.m0k.transmission WarningLegal -bool false
```

###############################################################################
### Spectacle.app                                                               #
###############################################################################

### Set up my preferred keyboard shortcuts
```bash
defaults write com.divisiblebyzero.Spectacle MakeLarger -data 62706c6973743030d40102030405061819582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708101155246e756c6cd4090a0b0c0d0e0d0f596d6f64696669657273546e616d65576b6579436f64655624636c6173731000800280035a4d616b654c6172676572d2121314155a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21617585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11a1b54726f6f74800108111a232d32373c424b555a62696b6d6f7a7f8a939c9fa8b1c3c6cb0000000000000101000000000000001c000000000000000000000000000000cd
defaults write com.divisiblebyzero.Spectacle MakeSmaller -data 62706c6973743030d40102030405061819582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708101155246e756c6cd4090a0b0c0d0e0d0f596d6f64696669657273546e616d65576b6579436f64655624636c6173731000800280035b4d616b65536d616c6c6572d2121314155a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21617585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11a1b54726f6f74800108111a232d32373c424b555a62696b6d6f7b808b949da0a9b2c4c7cc0000000000000101000000000000001c000000000000000000000000000000ce
defaults write com.divisiblebyzero.Spectacle MoveToBottomDisplay -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107d80035f10134d6f7665546f426f74746f6d446973706c6179d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a217185d5a65726f4b6974486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072888d98a1afb2c0c9dbdee30000000000000101000000000000001d000000000000000000000000000000e5
defaults write com.divisiblebyzero.Spectacle MoveToBottomHalf -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107d80035f10104d6f7665546f426f74746f6d48616c66d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072858a959ea7aab3bcced1d60000000000000101000000000000001d000000000000000000000000000000d8
defaults write com.divisiblebyzero.Spectacle MoveToCenter -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002100880035c4d6f7665546f43656e746572d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e70727f848f98a1a4adb6c8cbd00000000000000101000000000000001d000000000000000000000000000000d2
defaults write com.divisiblebyzero.Spectacle MoveToFullscreen -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002102e80035f10104d6f7665546f46756c6c73637265656ed2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072858a959ea7aab3bcced1d60000000000000101000000000000001d000000000000000000000000000000d8
defaults write com.divisiblebyzero.Spectacle MoveToLeftDisplay -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107b80035f10114d6f7665546f4c656674446973706c6179d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a217185d5a65726f4b6974486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072868b969fadb0bec7d9dce10000000000000101000000000000001d000000000000000000000000000000e3
defaults write com.divisiblebyzero.Spectacle MoveToLeftHalf -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107b80035e4d6f7665546f4c65667448616c66d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e70728186919aa3a6afb8cacdd20000000000000101000000000000001d000000000000000000000000000000d4
defaults write com.divisiblebyzero.Spectacle MoveToLowerLeft -data 62706c6973743030d40102030405061a1b582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731113008002107b80035f100f4d6f7665546f4c6f7765724c656674d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a31718195d5a65726f4b6974486f744b6579585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11c1d54726f6f74800108111a232d32373c424b555a62696c6e70728489949dabafbdc6cfe1e4e90000000000000101000000000000001e000000000000000000000000000000eb
defaults write com.divisiblebyzero.Spectacle MoveToLowerRight -data 62706c6973743030d40102030405061a1b582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731113008002107c80035f10104d6f7665546f4c6f7765725269676874d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a31718195d5a65726f4b6974486f744b6579585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11c1d54726f6f74800108111a232d32373c424b555a62696c6e7072858a959eacb0bec7d0e2e5ea0000000000000101000000000000001e000000000000000000000000000000ec
defaults write com.divisiblebyzero.Spectacle MoveToNextDisplay -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731118008002107c80035f10114d6f7665546f4e657874446973706c6179d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072868b969fa8abb4bdcfd2d70000000000000101000000000000001d000000000000000000000000000000d9
defaults write com.divisiblebyzero.Spectacle MoveToNextThird -data 62706c6973743030d40102030405061819582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708101155246e756c6cd4090a0b0c0d0e0d0f596d6f64696669657273546e616d65576b6579436f64655624636c6173731000800280035f100f4d6f7665546f4e6578745468697264d2121314155a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21617585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11a1b54726f6f74800108111a232d32373c424b555a62696b6d6f8186919aa3a6afb8cacdd20000000000000101000000000000001c000000000000000000000000000000d4
defaults write com.divisiblebyzero.Spectacle MoveToPreviousDisplay -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731118008002107b80035f10154d6f7665546f50726576696f7573446973706c6179d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e70728a8f9aa3acafb8c1d3d6db0000000000000101000000000000001d000000000000000000000000000000dd
defaults write com.divisiblebyzero.Spectacle MoveToPreviousThird -data 62706c6973743030d40102030405061819582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708101155246e756c6cd4090a0b0c0d0e0d0f596d6f64696669657273546e616d65576b6579436f64655624636c6173731000800280035f10134d6f7665546f50726576696f75735468697264d2121314155a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21617585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11a1b54726f6f74800108111a232d32373c424b555a62696b6d6f858a959ea7aab3bcced1d60000000000000101000000000000001c000000000000000000000000000000d8
defaults write com.divisiblebyzero.Spectacle MoveToRightDisplay -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107c80035f10124d6f7665546f5269676874446973706c6179d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a217185d5a65726f4b6974486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072878c97a0aeb1bfc8dadde20000000000000101000000000000001d000000000000000000000000000000e4
defaults write com.divisiblebyzero.Spectacle MoveToRightHalf -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107c80035f100f4d6f7665546f526967687448616c66d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e70728489949da6a9b2bbcdd0d50000000000000101000000000000001d000000000000000000000000000000d7
defaults write com.divisiblebyzero.Spectacle MoveToTopDisplay -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107e80035f10104d6f7665546f546f70446973706c6179d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a217185d5a65726f4b6974486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e7072858a959eacafbdc6d8dbe00000000000000101000000000000001d000000000000000000000000000000e2
defaults write com.divisiblebyzero.Spectacle MoveToTopHalf -data 62706c6973743030d4010203040506191a582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731119008002107e80035d4d6f7665546f546f7048616c66d2131415165a24636c6173736e616d655824636c6173736573585a4b486f744b6579a21718585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11b1c54726f6f74800108111a232d32373c424b555a62696c6e707280859099a2a5aeb7c9ccd10000000000000101000000000000001d000000000000000000000000000000d3
defaults write com.divisiblebyzero.Spectacle MoveToUpperLeft -data 62706c6973743030d40102030405061a1b582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731111008002107b80035f100f4d6f7665546f55707065724c656674d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a31718195d5a65726f4b6974486f744b6579585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11c1d54726f6f74800108111a232d32373c424b555a62696c6e70728489949dabafbdc6cfe1e4e90000000000000101000000000000001e000000000000000000000000000000eb
defaults write com.divisiblebyzero.Spectacle MoveToUpperRight -data 62706c6973743030d40102030405061a1b582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731111008002107c80035f10104d6f7665546f55707065725269676874d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a31718195d5a65726f4b6974486f744b6579585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11c1d54726f6f74800108111a232d32373c424b555a62696c6e7072858a959eacb0bec7d0e2e5ea0000000000000101000000000000001e000000000000000000000000000000ec
defaults write com.divisiblebyzero.Spectacle RedoLastMove -data 62706c6973743030d40102030405061a1b582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c617373110b008002100680035c5265646f4c6173744d6f7665d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a31718195d5a65726f4b6974486f744b6579585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11c1d54726f6f74800108111a232d32373c424b555a62696c6e70727f848f98a6aab8c1cadcdfe40000000000000101000000000000001e000000000000000000000000000000e6
defaults write com.divisiblebyzero.Spectacle UndoLastMove -data 62706c6973743030d40102030405061a1b582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a40708111255246e756c6cd4090a0b0c0d0e0f10596d6f64696669657273546e616d65576b6579436f64655624636c6173731109008002100680035c556e646f4c6173744d6f7665d2131415165a24636c6173736e616d655824636c61737365735d5a65726f4b6974486f744b6579a31718195d5a65726f4b6974486f744b6579585a4b486f744b6579584e534f626a6563745f100f4e534b657965644172636869766572d11c1d54726f6f74800108111a232d32373c424b555a62696c6e70727f848f98a6aab8c1cadcdfe40000000000000101000000000000001e000000000000000000000000000000e6
```