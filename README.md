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
