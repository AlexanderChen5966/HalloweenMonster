#!/usr/bin/env bash
set -euxo pipefail
mkdir -p out-android
adb wait-for-device
adb shell settings put global window_animation_scale 1
adb shell wm size | tee out-android/info.txt
tools/drive.sh emulator-5554 out-android \
  "(adb shell screenrecord --bit-rate 6000000 --time-limit 170 /sdcard/raw.mp4 >/dev/null 2>&1 &) ; sleep 1" \
  "adb shell pkill -INT screenrecord; sleep 3; adb pull /sdcard/raw.mp4 out-android/raw.mp4"
