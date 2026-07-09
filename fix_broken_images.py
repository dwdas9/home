"""
fix_broken_images.py
Re-writes broken image references in .md files.

Strategy:
  For each broken ref in a .md file, search all images under docs/ for a
  file whose name matches. If exactly one match is found, rewrite the
  reference to the correct relative path (using forward slashes). Refs that
  are ambiguous (multiple matches) or truly missing are reported but left
  untouched so they can be reviewed manually.
"""

import re
import os
from pathlib import Path

DOCS_DIR   = Path(__file__).parent / "docs"
REPORT_OUT = Path(__file__).parent / "fix_broken_images_report.txt"

# Patterns that match image references in markdown / HTML
IMG_PATTERNS = [
    # ![alt](path)  or  ![alt](path "title")
    re.compile(r'(!\[[^\]]*\]\()([^)\s"]+)((?:\s+"[^"]*")?\))'),
    # <img src="path" ...>  or  <img src='path' ...>
    re.compile(r'(<img\b[^>]*\bsrc=["\']\s*)([^"\'>\s]+)(\s*["\'][^>]*>)', re.IGNORECASE),
]

IMAGE_EXTENSIONS = {'.png', '.jpg', '.jpeg', '.gif', '.webp', '.svg'}


def build_image_index(docs_dir: Path) -> dict[str, list[Path]]:
    """Map each image filename (lowercase) to all matching paths under docs/."""
    index: dict[str, list[Path]] = {}
    for path in docs_dir.rglob("*"):
        if path.suffix.lower() in IMAGE_EXTENSIONS and path.is_file():
            key = path.name.lower()
            index.setdefault(key, []).append(path)
    return index


def relative_posix(from_md: Path, image_path: Path) -> str:
    """Return POSIX-style relative path from the md file to the image."""
    rel = os.path.relpath(image_path, from_md.parent)
    return Path(rel).as_posix()


def fix_file(md_path: Path, image_index: dict[str, list[Path]],
             fixed: list, skipped: list, truly_missing: list) -> int:
    """Fix broken image refs in one .md file. Returns count of fixes made."""
    try:
        text = md_path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        text = md_path.read_text(encoding="latin-1")

    new_text = text
    changes = 0

    for pattern in IMG_PATTERNS:
        def replacer(m, md=md_path):
            prefix, ref_str, suffix = m.group(1), m.group(2), m.group(3)
            # Skip absolute URLs and anchors
            if ref_str.startswith(("http://", "https://", "#", "/")):
                return m.group(0)
            # Resolve path relative to the md file
            ref_path = (md.parent / ref_str.replace("\\", "/")).resolve()
            if ref_path.exists():
                return m.group(0)  # not actually broken

            # Search by filename only
            fname = Path(ref_str).name.lower()
            candidates = image_index.get(fname, [])

            if len(candidates) == 1:
                corrected = relative_posix(md, candidates[0])
                fixed.append(f"  {md.relative_to(DOCS_DIR.parent)}: {ref_str!r} -> {corrected!r}")
                return f"{prefix}{corrected}{suffix}"
            elif len(candidates) > 1:
                # Tie-break: prefer candidate in same folder's images/ sub-dir
                preferred = [c for c in candidates if c.parent == md.parent / "images"]
                if not preferred:
                    preferred = [c for c in candidates if c.parent.name == "images"
                                 and c.parent.parent == md.parent]
                if not preferred:
                    # Use candidate in the closest ancestor images/ dir
                    for ancestor in md.parents:
                        preferred = [c for c in candidates if c.parent == ancestor / "images"]
                        if preferred:
                            break
                if len(preferred) == 1:
                    corrected = relative_posix(md, preferred[0])
                    fixed.append(f"  {md.relative_to(DOCS_DIR.parent)}: {ref_str!r} -> {corrected!r} (tie-break)")
                    return f"{prefix}{corrected}{suffix}"
                skipped.append(
                    f"  {md.relative_to(DOCS_DIR.parent)}: {ref_str!r} — {len(candidates)} matches: "
                    + ", ".join(str(c.relative_to(DOCS_DIR)) for c in candidates[:3])
                )
                return m.group(0)
            else:
                truly_missing.append(f"  {md.relative_to(DOCS_DIR.parent)}: {ref_str!r}")
                return m.group(0)

        result = pattern.sub(replacer, new_text)
        if result != new_text:
            changes += new_text.count(result) + 1   # approximate
            new_text = result

    if new_text != text:
        md_path.write_text(new_text, encoding="utf-8")
        return 1
    return 0


def main():
    print("Building image index…")
    image_index = build_image_index(DOCS_DIR)
    print(f"  {sum(len(v) for v in image_index.values())} images indexed.")

    fixed: list[str]         = []
    skipped: list[str]       = []
    truly_missing: list[str] = []

    md_files = sorted(DOCS_DIR.rglob("*.md"))
    files_changed = 0
    for md in md_files:
        n = fix_file(md, image_index, fixed, skipped, truly_missing)
        files_changed += n

    lines = [
        "=" * 70,
        "BROKEN IMAGE FIX REPORT",
        f"Files changed : {files_changed}",
        "=" * 70,
        "",
        f"── FIXED ({len(fixed)}) ──────────────────────────────────────────────────",
    ]
    lines += fixed or ["  None."]
    lines += [
        "",
        f"── AMBIGUOUS / SKIPPED ({len(skipped)}) ─────────────────────────────────",
    ]
    lines += skipped or ["  None."]
    lines += [
        "",
        f"── TRULY MISSING (no file on disk) ({len(truly_missing)}) ───────────────",
    ]
    lines += truly_missing or ["  None."]
    lines += [
        "",
        "=" * 70,
        f"SUMMARY: {len(fixed)} fixed, {len(skipped)} ambiguous, {len(truly_missing)} truly missing.",
        "=" * 70,
    ]
    report = "\n".join(lines)
    print(report)
    REPORT_OUT.write_text(report, encoding="utf-8")
    print(f"\nFull report saved to: {REPORT_OUT}")


if __name__ == "__main__":
    main()
