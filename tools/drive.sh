#!/usr/bin/env bash
# Usage: drive.sh <device-id> <out-dir> <start-recording-cmd> <stop-recording-cmd>
# Runs the integration test; starts the screen recorder when the app prints READY.
set -uo pipefail
DEVICE="$1"; OUT="$2"; START="$3"; STOP="$4"
mkdir -p "$OUT/screenshots"
export SHOT_DIR="$OUT/screenshots"
flutter drive -v --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart -d "$DEVICE" > "$OUT/drive.log" 2>&1 &
DRIVE_PID=$!
# Watchdog: dump the log tail and abort if the run hangs (e.g. VM service never connects).
( sleep "${DRIVE_TIMEOUT:-900}"; if kill -0 $DRIVE_PID 2>/dev/null; then
    echo "WATCHDOG: flutter drive hung"; tail -n 60 "$OUT/drive.log"; pkill -P $DRIVE_PID; kill $DRIVE_PID; fi ) &
WATCHDOG_PID=$!
until grep -q "READY" "$OUT/drive.log" 2>/dev/null; do
  kill -0 $DRIVE_PID 2>/dev/null || { echo "flutter drive exited before READY"; exit 1; }
  sleep 0.5
done
T0=$(python3 -c 'import time;print(int(time.time()*1000))')
eval "$START"
until grep -q "MARK_END" "$OUT/drive.log" 2>/dev/null; do
  kill -0 $DRIVE_PID 2>/dev/null || break
  sleep 0.5
done
sleep 2
eval "$STOP"
wait $DRIVE_PID; RC=$?
kill $WATCHDOG_PID 2>/dev/null || true
grep -E "READY|MARK_|EXCEPTION|Some tests failed|All tests passed" "$OUT/drive.log" | head -20 || true
S=$(grep -o 'MARK_START [0-9]*' "$OUT/drive.log" | head -1 | cut -d' ' -f2)
E=$(grep -o 'MARK_END [0-9]*' "$OUT/drive.log" | head -1 | cut -d' ' -f2)
echo "{\"rec_start\":$T0,\"mark_start\":${S:-0},\"mark_end\":${E:-0}}" > "$OUT/marks.json"
exit $RC
