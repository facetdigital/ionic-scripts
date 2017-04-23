#!/bin/sh

ionic plugin rm cordova-plugin-console --save
ionic build android --prod --release
ionic plugin add cordova-plugin-console --save
