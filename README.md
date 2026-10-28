# 🎃 萬聖節妖怪圖鑑 (HalloweenMonster)

Flutter App，介紹 8 位經典萬聖節妖怪：吸血鬼、狼人、科學怪人、女巫、南瓜燈傑克、骷髏、木乃伊、死神。

## 執行
```bash
flutter pub get
flutter run
```

## 錄影與上架截圖（GitHub Actions）
`.github/workflows/record.yml` 會：
1. macOS runner：在 iPhone Pro Max 模擬器執行 `integration_test/app_test.dart`，錄影並截圖
2. Ubuntu runner：在 Pixel 模擬器做同樣的事
3. 用 ffmpeg 裁掉非 App 操作的片段並壓縮，並把截圖合成上架用圖，輸出到 `deliverables` artifact

## 圖片來源
圖片皆來自 Wikimedia Commons（公有領域），App 內詳情頁也有標註：
vampire — Max Schreck 飾演 Count Orlok《Nosferatu》(1922)；werewolf — Lucas Cranach《Werwolf》(1512)；
frankenstein — 《Frankenstein》1831 年版插圖；witch — Witch winks 童謠插畫；jack — Book of Halloween；
skeleton — Guyot Marchand《Danse Macabre》；mummy — Ginger (mummy)；death — Gustave Doré《Death on the Pale Horse》。

App Icon 為自行繪製。

## 成品（release/）
- `release/videos/`：iPhone 17 Pro Max 與 Pixel（螢幕設為 Pixel 10 的 1080×2424）的操作影片，已裁掉非 App 的部分並壓縮
- `release/store/AppStore_1320x2868/`、`release/store/GooglePlay_1080x1920/`：上架用截圖
- `release/app_icon_1024.png`：App Icon（原始檔在 `assets/icon/icon.png`）

註：GitHub runner 沒有 iPhone 18 Pro Max，iPhone 影片以 iPhone 17 Pro Max 錄製。
