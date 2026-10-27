"""Trim + compress the recordings and compose App Store / Play Store screenshots."""
import json, os, subprocess, sys
from PIL import Image, ImageDraw, ImageFont, ImageOps

FONT = "/usr/share/fonts/opentype/noto/NotoSansCJK-Bold.ttc"
CAPTIONS = {
    "1_home": ("萬聖節妖怪圖鑑", "一次認識 8 位經典妖怪"),
    "2_vampire": ("吸血鬼", "夜晚的貴族，以鮮血為食"),
    "3_werewolf": ("狼人", "滿月之夜，人性消失"),
    "4_frankenstein": ("科學怪人", "由人類創造的孤獨生命"),
    "5_list_more": ("滑動探索", "骷髏、木乃伊、死神⋯⋯"),
    "6_witch": ("女巫", "騎著掃帚，煮著大鍋湯"),
}
SIZES = {"ios": (1320, 2868), "android": (1080, 1920)}


def trim_compress(plat, raw):
    m = json.load(open(f"out-{plat}/marks.json"))
    ss = max(0, (m["mark_start"] - m["rec_start"]) / 1000 - 0.3)
    to = (m["mark_end"] - m["rec_start"]) / 1000 + 1.0
    os.makedirs("deliver", exist_ok=True)
    out = f"deliver/{plat}_demo.mp4"
    subprocess.run(["ffmpeg", "-y", "-ss", f"{ss:.2f}", "-to", f"{to:.2f}", "-i", raw,
                    "-vf", "scale=-2:1280:flags=lanczos,fps=30", "-c:v", "libx264", "-crf", "30",
                    "-preset", "slow", "-pix_fmt", "yuv420p", "-movflags", "+faststart", "-an", out],
                   check=True)
    print(out, os.path.getsize(out) // 1024, "KB")


def compose(plat):
    W, H = SIZES[plat]
    os.makedirs(f"deliver/{plat}_store", exist_ok=True)
    big = ImageFont.truetype(FONT, int(W * 0.085), index=0)
    small = ImageFont.truetype(FONT, int(W * 0.042), index=0)
    for name, (title, sub) in CAPTIONS.items():
        src = f"out-{plat}/screenshots/{name}.png"
        if not os.path.exists(src):
            continue
        im = Image.open(src).convert("RGB")
        canvas = Image.new("RGB", (W, H))
        d = ImageDraw.Draw(canvas)
        for y in range(H):  # purple -> dark gradient
            t = y / H
            d.line([(0, y), (W, y)], fill=(int(70 - 50 * t), int(20 - 8 * t), int(110 - 70 * t)))
        d.text((W / 2, H * 0.07), title, font=big, fill=(255, 140, 40), anchor="mm")
        d.text((W / 2, H * 0.115), sub, font=small, fill=(235, 225, 245), anchor="mm")
        th = int(H * 0.82)
        tw = int(im.width * th / im.height)
        if tw > W * 0.9:
            tw = int(W * 0.9); th = int(im.height * tw / im.width)
        shot = im.resize((tw, th), Image.LANCZOS)
        mask = Image.new("L", shot.size, 0)
        ImageDraw.Draw(mask).rounded_rectangle((0, 0, tw, th), radius=int(tw * 0.06), fill=255)
        canvas.paste(shot, ((W - tw) // 2, H - th - int(H * 0.025)), mask)
        canvas.save(f"deliver/{plat}_store/{name}.png", optimize=True)
        im.save(f"deliver/{plat}_store/raw_{name}.png", optimize=True)


for plat in ("ios", "android"):
    raw = next((f"out-{plat}/{f}" for f in ("raw.mov", "raw.mp4") if os.path.exists(f"out-{plat}/{f}")), None)
    if raw:
        trim_compress(plat, raw)
    compose(plat)
