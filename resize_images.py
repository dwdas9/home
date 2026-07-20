"""
resize_images.py
----------------
Walks docs/ recursively and resizes any image whose width exceeds MAX_WIDTH.
Images are overwritten in-place; aspect ratio is preserved.
Animated GIFs are skipped (Pillow cannot round-trip them cleanly).

Usage:
    python resize_images.py
"""

import os
from pathlib import Path
from PIL import Image, UnidentifiedImageError

DOCS_DIR = Path(__file__).parent / "docs"
MAX_WIDTH = 800
EXTENSIONS = {".png", ".jpg", ".jpeg", ".gif", ".webp"}


def resize_image(path: Path) -> bool:
    """Return True if the image was resized, False otherwise."""
    try:
        img = Image.open(path)
    except UnidentifiedImageError:
        print(f"  SKIP (unrecognised format): {path.relative_to(DOCS_DIR)}")
        return False

    # Skip animated GIFs
    if getattr(img, "is_animated", False):
        print(f"  SKIP (animated GIF):        {path.relative_to(DOCS_DIR)}")
        return False

    orig_w, orig_h = img.size
    if orig_w <= MAX_WIDTH:
        return False

    new_w = MAX_WIDTH
    new_h = int(orig_h * MAX_WIDTH / orig_w)
    img = img.resize((new_w, new_h), Image.LANCZOS)

    # Preserve EXIF/metadata where possible
    save_kwargs = {}
    fmt = img.format or path.suffix.lstrip(".").upper()
    if fmt in ("JPEG", "JPG"):
        save_kwargs["quality"] = 90
        save_kwargs["optimize"] = True

    img.save(path, **save_kwargs)
    print(f"  RESIZED: {path.relative_to(DOCS_DIR)}  {orig_w}x{orig_h} -> {new_w}x{new_h}")
    return True


def main():
    resized = 0
    total = 0

    for root, _, files in os.walk(DOCS_DIR):
        for fname in files:
            p = Path(root) / fname
            if p.suffix.lower() not in EXTENSIONS:
                continue
            total += 1
            if resize_image(p):
                resized += 1

    print(f"\nDone. Checked {total} images, resized {resized}.")


if __name__ == "__main__":
    main()
