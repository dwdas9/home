"""
audit_links.py
--------------
Scans every .md file under docs/ and reports:
  1. Broken image references  (![...](path) and <img src="...">)
  2. Broken internal markdown links  ([text](path))
  3. Orphaned image files  (images that exist but are never referenced)

Output is written to audit_links_report.txt (and also printed to stdout).

Usage:
    python audit_links.py
"""

import os
import re
from pathlib import Path
from urllib.parse import unquote

DOCS_DIR = Path(__file__).parent / "docs"
REPORT_FILE = Path(__file__).parent / "audit_links_report.txt"

IMAGE_EXTS = {".png", ".jpg", ".jpeg", ".gif", ".webp", ".svg"}

# ── regex patterns ────────────────────────────────────────────────────────────
# Markdown image:   ![alt](path)
RE_MD_IMAGE = re.compile(r"!\[.*?\]\(([^)]+)\)")
# HTML img tag:     <img src="path"
RE_HTML_IMG = re.compile(r'<img[^>]+src=["\']([^"\']+)["\']', re.IGNORECASE)
# Markdown link:    [text](path)  — internal only (no http/https/mailto/anchor-only)
RE_MD_LINK = re.compile(r"(?<!!)\[.*?\]\(([^)]+)\)")


def is_external(href: str) -> bool:
    return href.startswith(("http://", "https://", "mailto:", "#", "//"))


def resolve(ref: str, source_file: Path) -> Path:
    """Resolve a relative reference from the perspective of source_file."""
    ref = unquote(ref.split("#")[0].strip())  # strip fragment and decode
    if not ref:
        return None
    p = Path(ref)
    if p.is_absolute():
        return DOCS_DIR / p.relative_to("/")
    return (source_file.parent / p).resolve()


def collect_all_images() -> set:
    """Return absolute paths of every image file under docs/."""
    images = set()
    for root, _, files in os.walk(DOCS_DIR):
        for f in files:
            p = Path(root) / f
            if p.suffix.lower() in IMAGE_EXTS:
                images.add(p.resolve())
    return images


def audit():
    broken_images: list[tuple[Path, int, str]] = []   # (md_file, line_no, ref)
    broken_links: list[tuple[Path, int, str]] = []
    referenced_images: set[Path] = set()

    md_files = sorted(DOCS_DIR.rglob("*.md"))

    for md_path in md_files:
        text = md_path.read_text(encoding="utf-8", errors="replace")
        lines = text.splitlines()

        for lineno, line in enumerate(lines, start=1):
            # ── image references ──────────────────────────────────────────
            for pat in (RE_MD_IMAGE, RE_HTML_IMG):
                for m in pat.finditer(line):
                    ref = m.group(1).strip()
                    if is_external(ref):
                        continue
                    target = resolve(ref, md_path)
                    if target is None:
                        continue
                    if target.suffix.lower() in IMAGE_EXTS:
                        referenced_images.add(target)
                    if not target.exists():
                        broken_images.append((md_path, lineno, ref))

            # ── internal markdown links ───────────────────────────────────
            for m in RE_MD_LINK.finditer(line):
                ref = m.group(1).strip()
                if is_external(ref):
                    continue
                # skip pure anchors
                if ref.startswith("#"):
                    continue
                target = resolve(ref, md_path)
                if target is None:
                    continue
                # only flag .md links and image links, not bare fragments
                if target.suffix.lower() not in {".md"} | IMAGE_EXTS:
                    continue
                if not target.exists():
                    # avoid double-reporting what was already caught as a broken image
                    if target.suffix.lower() in IMAGE_EXTS:
                        continue
                    broken_links.append((md_path, lineno, ref))

    all_images = collect_all_images()
    orphaned = sorted(all_images - referenced_images)

    return broken_images, broken_links, orphaned, md_files


def rel(p: Path) -> str:
    try:
        return str(p.relative_to(DOCS_DIR))
    except ValueError:
        return str(p)


def main():
    print("Scanning …")
    broken_images, broken_links, orphaned, md_files = audit()

    lines = []
    lines.append("=" * 70)
    lines.append("BROKEN LINK / IMAGE AUDIT REPORT")
    lines.append(f"Docs folder : {DOCS_DIR}")
    lines.append(f"Markdown files scanned : {len(md_files)}")
    lines.append("=" * 70)

    lines.append(f"\n── BROKEN IMAGE REFERENCES ({len(broken_images)}) ──────────────────────────")
    if broken_images:
        for md_path, lineno, ref in sorted(broken_images, key=lambda x: (x[0], x[1])):
            lines.append(f"  {rel(md_path)}:{lineno}  →  {ref}")
    else:
        lines.append("  None found.")

    lines.append(f"\n── BROKEN INTERNAL LINKS ({len(broken_links)}) ───────────────────────────────")
    if broken_links:
        for md_path, lineno, ref in sorted(broken_links, key=lambda x: (x[0], x[1])):
            lines.append(f"  {rel(md_path)}:{lineno}  →  {ref}")
    else:
        lines.append("  None found.")

    lines.append(f"\n── ORPHANED IMAGES ({len(orphaned)}) ─────────────────────────────────────")
    lines.append("  (exist on disk but are never referenced in any .md file)")
    if orphaned:
        for p in orphaned:
            lines.append(f"  {rel(p)}")
    else:
        lines.append("  None found.")

    lines.append("\n" + "=" * 70)
    lines.append(f"SUMMARY: {len(broken_images)} broken images, "
                 f"{len(broken_links)} broken links, "
                 f"{len(orphaned)} orphaned images.")
    lines.append("=" * 70)

    report = "\n".join(lines)
    print(report)
    REPORT_FILE.write_text(report, encoding="utf-8")
    print(f"\nFull report saved to: {REPORT_FILE.name}")


if __name__ == "__main__":
    main()
