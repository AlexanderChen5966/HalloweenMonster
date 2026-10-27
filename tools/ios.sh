#!/usr/bin/env bash
set -euxo pipefail
WANT="${IOS_DEVICE:-iPhone 18 Pro Max}"
xcrun simctl list devicetypes | grep -i "iphone" || true
TYPE_ID=$(xcrun simctl list devicetypes -j | python3 -c "
import json,sys,re
want=sys.argv[1]
t=json.load(sys.stdin)['devicetypes']
names={x['name']:x['identifier'] for x in t}
if want in names: print(names[want]); sys.exit()
pm=[n for n in names if re.fullmatch(r'iPhone \d+ Pro Max',n)]
pm.sort(key=lambda n:int(n.split()[1]))
print(names[pm[-1]])" "$WANT")
RUNTIME=$(xcrun simctl list runtimes -j | python3 -c "
import json,sys
r=[x for x in json.load(sys.stdin)['runtimes'] if x['isAvailable'] and x['platform']=='iOS']
r.sort(key=lambda x:[int(p) for p in x['version'].split('.')])
print(r[-1]['identifier'])")
UDID=$(xcrun simctl create "HM-Sim" "$TYPE_ID" "$RUNTIME")
echo "device type: $TYPE_ID  runtime: $RUNTIME" | tee out-ios-info.txt
xcrun simctl boot "$UDID"
xcrun simctl bootstatus "$UDID" -b
xcrun simctl status_bar "$UDID" override --time "9:41" --batteryState charged --batteryLevel 100 --cellularBars 4 --wifiBars 3 || true
mkdir -p out-ios
cp out-ios-info.txt out-ios/
tools/drive.sh "$UDID" out-ios \
  "xcrun simctl io $UDID recordVideo --codec h264 --force out-ios/raw.mov & echo \$! > out-ios/rec.pid; sleep 1" \
  "kill -INT \$(cat out-ios/rec.pid); sleep 3"
