#!/bin/bash

TARGET=$(find /sys/devices/w1_bus_master1/28* | grep w1_slave)
TEMP=$(cat $TARGET | grep -o 't=.*' | grep -o '[0-9]*' | python -c 'import sys; temp = sys.stdin.read().strip(); print(int(temp) / 1000.0)')
DATE=$(date)
CELCIUS_DEGREE="°C"
TEMP_STRING="- At $DATE, temperature reading is: $TEMP"
TEMP_STRING=$TEMP_STRING$CELCIUS_DEGREE

echo "Building..."
echo $TEMP | python commiter.py
echo "Complete. Pushing.."

rm -rf .git

git init
git config user.email "mufid+thermofidzcommiter@outlook.com"
git config user.name "Thermofidz Updater"
git add README.md
git add docs
git add worker.sh
git add commiter.py
git add crontab
git commit -m "Temp update $DATE"
git remote add origin git@github.com:mufid/thermofidz.git
git push -uf origin master
