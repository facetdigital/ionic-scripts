This repository contains a few helper scripts that we use for Ionic development on macOS.

## Install Scripts

  * `install-android-sdk.sh` - Used to install all the Android SDK and packages on macOS that are needed to build Ionic projects for Android. Has some environment variable pre-requisites, as described in the error messages it outputs, and/or our internal wiki at [Ionic Build & Testing within a Mac VM](https://github.com/facetdigital/wiki/wiki/Ionic-Build-&-Testing-within-a-Mac-VM).

## Build Scripts

  * `build-android-dev.sh` - Builds an `*.apk` package in development mode that can be sideloaded onto an Android device or used with AWS Device Farm for testing.
  * `build-android-prod.sh` - Builds an _unsigned_ `*.apk` package in production mode that can be sideloaded onto an Android device or used with AWS Device Farm for testing.
  * `build-ios-dev-emulator.sh` - Builds the `*.app` package for the iOS emulator.
  * `build-ios-prod.sh` - Builds signed `*.ipa` in production mode that is ready to upload to the App Store.

## Run Scripts

  * `run-ios-dev.sh` - If your iOS device is attached, will build the app in development mode, download it to the device, and run it, with a livereload server attached, and console output from the app going to the terminal. If no iOS device is attached, it will use the simulator.
