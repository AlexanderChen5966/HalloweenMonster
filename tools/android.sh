#!/usr/bin/env bash
set -euxo pipefail
mkdir -p out-android
adb wait-for-device
adb shell settings put global window_animation_scale 1
# avdmanager on the runner has no Pixel 8+ profiles: emulate Pixel 10's display (6.3", 1080x2424, 420dpi).
adb shell wm size 1080x2424
adb shell wm density 420
adb shell wm size | tee out-android/info.txt
adb shell wm density | tee -a out-android/info.txt
tools/drive.sh emulator-5554 out-android \
  "(adb shell screenrecord --bit-rate 6000000 --time-limit 170 /sdcard/raw.mp4 >/dev/null 2>&1 &) ; sleep 1" \
  "adb shell pkill -INT screenrecord; sleep 3; adb pull /sdcard/raw.mp4 out-android/raw.mp4"
