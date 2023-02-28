#!/usr/bin/env bash

echo "Building"

npm install
npm run build

if [ -d "cordova-app/www/" ]; then
    echo "Cordova project already exists"
    cd cordova-app
    npm install
    rm -rf platforms/ plugins/ www/*
    cp -R ../dist/* www/
    cordova platform add android@11.0.0 --no-telemetry
    cordova build android --dev --packageType=apk --gradleArg=-PcdvCompileSdkVersion=31
else
    echo "Create cordova project"
    cordova create cordova-app com.example.myapp MyApp --no-telemetry
    cd cordova-app
    cordova platform add android@11.0.0 --no-telemetry
    cp -R ../dist/* www/
    cordova build android --dev --packageType=apk --gradleArg=-PcdvCompileSdkVersion=31
fi