#!/usr/bin/env bash

echo "Rodando build"

npm install
npm run build:dev

if [ -d "cordova-app/www/" ]; then
    echo "Existe"
    cd cordova-app
    npm install
    cp config.xml-dev config.xml
    cp -R ../dist/* www/
    cordova platform add android@11.0.0 --no-telemetry
    cordova build android --dev --packageType=apk --gradleArg=-PcdvCompileSdkVersion=31
fi