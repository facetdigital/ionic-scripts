#!/bin/sh
###############################################################################
# Usage:
#
#   ./install-android-sdk.sh
#
# Prerequisites:
#
#   * Java JDK 1.8.0+ installed and `java` is in your path.
#   * $JAVA_HOME is set.
#   * $JAVA_HOME/bin is in your $PATH.
#   * $ANDROID_HOME is set to where we will install SDK tools.
#   * $ANDROID_HOME/tools is in your $PATH.
#   * $ANDROID_HOME/platform-tools is in your $PATH.
#
###############################################################################

###############################################################################
# Verify Prerequisites
###############################################################################
date
echo "Verifying prerequisites..."

# Verify Java Installed
which java > /dev/null
if [ $? -ne 0 ]; then
  echo
  echo "ERROR: Java is not installed. Please install JDK 1.8.0 or later"
  echo "       before proceeding."
  echo
  exit -1
fi

# Verify $JAVA_HOME is set
if [ -z "$JAVA_HOME" ]; then
  echo
  echo "ERROR: \$JAVA_HOME is not set. Please make sure it is set to"
  echo "       something like"
  echo "       /Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home"
  echo "       before proceeding."
  echo
  exit -1
fi

# Verify $JAVA_HOME/bin is in the $PATH
echo "$PATH" | grep -q "$JAVA_HOME/bin" > /dev/null
if [ $? -ne 0 ]; then
  echo
  echo "ERROR: \$PATH does not include Java. Please make sure"
  echo "       $JAVA_HOME/bin"
  echo "       is in your \$PATH before proceeding."
  echo
  exit -1
fi

# Verify $ANDROID_HOME is set
if [ -z "$ANDROID_HOME" ]; then
  echo
  echo "ERROR: \$ANDROID_HOME is not set. Please make sure it is set to"
  echo "       something like /Users/scottwb/Library/Android/sdk before"
  echo "       proceeding."
  echo
  exit -1
fi

# Verify $ANDROID_HOME/tools is in the $PATH
echo "$PATH" | grep -q "$ANDROID_HOME/tools" > /dev/null
if [ $? -ne 0 ]; then
  echo
  echo "ERROR: \$PATH does not include Android Tools. Please make sure"
  echo "       $ANDROID_HOME/tools"
  echo "       is in your \$PATH before proceeding."
  echo
  exit -1
fi

# Verify $ANDROID_HOME/platform-tools is in the $PATH
echo "$PATH" | grep -q "$ANDROID_HOME/platform-tools" > /dev/null
if [ $? -ne 0 ]; then
  echo
  echo "ERROR: \$PATH does not include Android Platform Tools. Please make sure"
  echo "       $ANDROID_HOME/platform-tools"
  echo "       is in your \$PATH before proceeding."
  echo
  exit -1
fi


###############################################################################
# Install Android SDK CLI Tools
#
#   NOTE: We have to hard-code the latest pre-25.3.0 version, because as of 25.3.0,
#         They deprecate the `android` command and omit the `templates` directory,
#         which breaks Ionic/Cordova, as described in a number of internet posts:
#
#           http://stackoverflow.com/questions/41407396/is-gui-for-android-sdk-manager-gone
#           http://stackoverflow.com/questions/33123898/missing-gradle-in-android-sdk-using-cordova-ionic
#           http://stackoverflow.com/questions/42652686/cordova-gradle-wrapper-missing-in-android-sdk
#           http://stackoverflow.com/questions/42613882/error-could-not-find-gradle-wrapper-within-android-sdk-might-need-to-update-yo
#
#         And as filed as an issue with Ionic here (with a future resolution
#         in a newer version of Cordova):
#
#           https://github.com/driftyco/ionic/issues/10604
# 
#         The main workaround we have described here:
#
#           https://forum.ionicframework.com/t/error-could-not-find-gradle-wrapper-within-android-sdk/79527/5
#           http://stackoverflow.com/questions/26016770/how-to-install-old-version-of-android-build-tools-from-command-line
#
###############################################################################
echo "Making sure \$ANDROID_HOME directory exists..."
mkdir -p "$ANDROID_HOME"
pushd "$ANDROID_HOME" > /dev/null

echo "Downloading and installing Android SDK Tools v 25.2.5..."
wget https://dl.google.com/android/repository/tools_r25.2.5-macosx.zip
unzip tools_r25.2.5-macosx.zip
rm tools_r25.2.5-macosx.zip


###############################################################################
# Install Packages via SDK Manager
#
# NOTE: The list of packages needed to build with Cordva on macOS were
#       compiled from a blog post that described several of the errors we
#       encountered during initial setup, plus some trial and error.
###############################################################################

############################################################
# Install Build Tools
############################################################
echo "Installing Build Tools..."
./tools/bin/sdkmanager "platform-tools"                                     # Android SDK Platform-tools
./tools/bin/sdkmanager "build-tools;25.0.2"                                 # Android SDK Build-tools


############################################################
# Install API 25 Packages (latest)
#
# NOTE: If building for a newer API version, we believe
#       you will need to make sure all of these are
#       installed for whatever is the latest you are 
#       building to, but not necessarily for the older
#       versions that we install after that.
############################################################
echo "Installing API 25 packages..."
./tools/bin/sdkmanager "platforms;android-25"                               # SDK Platform
./tools/bin/sdkmanager "system-images;android-25;android-tv;x86"            # Android TV Intel x86 Atom System Image
./tools/bin/sdkmanager "system-images;android-25;google_apis;arm64-v8a"     # Google APIs ARM 64 v8a System Image
./tools/bin/sdkmanager "system-images;android-25;google_apis;armeabi-v7a"   # Google APIs ARM EABI v7a System Image
./tools/bin/sdkmanager "system-images;android-25;google_apis;x86_64"        # Google APIs Intel x86 Atom_64 System Image
./tools/bin/sdkmanager "sources;android-25"                                 # Sources for Android 25

 
############################################################
# Install API 23
############################################################
echo "Installing API 23 packages..."
./tools/bin/sdkmanager "platforms;android-23"                               # Android SDK Platform 23
./tools/bin/sdkmanager "system-images;android-23;google_apis;armeabi-v7a"   # Google APIs ARM EABI v7a System Image


############################################################
# Install API 22
############################################################
echo "Installing API 22 packages..."
./tools/bin/sdkmanager "platforms;android-22"                               # Android SDK Platform 22
./tools/bin/sdkmanager "sources;android-22"                                 # Sources for Android 22


############################################################
# Install API 21
############################################################
echo "Installing API 21 packages..."
./tools/bin/sdkmanager "platforms;android-21"                               # Android SDK Platform 21
./tools/bin/sdkmanager "sources;android-21"                                 # Sources for Android 21


############################################################
# Install Extras
############################################################
echo "Installing Extras packages..."
./tools/bin/sdkmanager "extras;android;m2repository"                        # Android Support Repository
./tools/bin/sdkmanager "extras;google;google_play_services"                 # Google Play services
./tools/bin/sdkmanager "extras;google;m2repository"                         # Google Repository


############################################################
# Cleanup
############################################################
popd > /dev/null
echo "Done."
date
