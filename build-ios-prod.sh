#!/bin/sh

#ionic remove platform ios
#ionic platforms rm ios
#ionic platforms add ios

ionic state reset
ionic plugin rm cordova-plugin-console --save
ionic build ios --prod --release --device
ionic plugin add cordova-plugin-console --save
