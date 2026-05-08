#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q flashplayer-standalone | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON="https://upload.wikimedia.org/wikipedia/commons/1/1f/Adobe_Flash_Player_v10_icon.png"
export DESKTOP=/usr/share/applications/flashplayer.desktop
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/flashplayer

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
