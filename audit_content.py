"""
audit_content.py
----------------
Audits the docs/ folder for content health and reports:
  1. Stub files  (< 150 words — likely unfinished drafts)
  2. Files in docs/ NOT listed in mkdocs.yml  (orphaned markdown)
  3. Entries in mkdocs.yml nav pointing to files that do NOT exist

Output is written to audit_content_report.txt (and also printed to stdout).

Usage:
    python audit_content.py
"""

import re
from pathlib import Path

DOCS_DIR = Path(__file__).parent / "docs"
MKDOCS_YML = Path(__file__).parent / "mkdocs.yml"
REPORT_FILE = Path(__file__).parent / "audit_content_report.txt"

STUB_WORD_THRESHOLD = 150


def word_count(text: str) -> int:
    # Strip HTML tags and markdown syntax before counting
    text = re.sub(r"<[^>]+>", " ", text)
    text = re.sub(r"[#*`_\[\]()>|~]", " ", text)
    return len(text.split())


def collect_nav_refs(yml_text: str) -> set[str]:
    """Extract all quoted .md file paths from the nav section of mkdocs.yml."""
    # Strip comment lines first to avoid false positives
    no_comments = "\n".join(
        line for line in yml_text.splitlines() if not line.lstrip().startswith("#")
    )
    # Match any single- or double-quoted string ending in .md
    return {m.group(1) for m in re.finditer(r"['\"]([^'\"]+\.md)['\"]", no_comments)}


def main():
    yml_text = MKDOCS_YML.read_text(encoding="utf-8", errors="replace")
    nav_refs = collect_nav_refs(yml_text)          # relative to docs/

    all_md = sorted(DOCS_DIR.rglob("*.md"))

    # Normalise paths to forward-slash, relative to docs/
    def rel(p: Path) -> str:
        return p.relative_to(DOCS_DIR).as_posix()

    all_md_rel = {rel(p) for p in all_md}

    # 1. Stubs
    stubs: list[tuple[str, int]] = []
    for p in all_md:
        text = p.read_text(encoding="utf-8", errors="replace")
        wc = word_count(text)
        if wc < STUB_WORD_THRESHOLD:
            stubs.append((rel(p), wc))
    stubs.sort(key=lambda x: x[1])

    # 2. Orphaned markdown (exist on disk, not in nav)
    # blog/index.md is auto-managed by the blog plugin — exclude it
    auto_managed = {"blog/index.md"}
    orphaned_md = sorted(all_md_rel - nav_refs - auto_managed)

    # 3. Nav entries pointing to missing files
    missing_nav: list[str] = []
    for ref in sorted(nav_refs):
        target = DOCS_DIR / ref
        if not target.exists():
            missing_nav.append(ref)

    # ── Report ────────────────────────────────────────────────────────────────
    lines = []
    lines.append("=" * 70)
    lines.append("CONTENT AUDIT REPORT")
    lines.append(f"Docs folder  : {DOCS_DIR}")
    lines.append(f"Total .md files : {len(all_md)}")
    lines.append(f"Nav entries     : {len(nav_refs)}")
    lines.append("=" * 70)

    lines.append(f"\n── STUB FILES — fewer than {STUB_WORD_THRESHOLD} words ({len(stubs)}) ─────────────")
    lines.append("  (likely unfinished drafts — review, expand, merge, or delete)")
    if stubs:
        for path, wc in stubs:
            lines.append(f"  {wc:>5} words  {path}")
    else:
        lines.append("  None found.")

    lines.append(f"\n── ORPHANED MARKDOWN FILES ({len(orphaned_md)}) ──────────────────────────────")
    lines.append("  (exist on disk but not listed in mkdocs.yml nav)")
    if orphaned_md:
        for path in orphaned_md:
            lines.append(f"  {path}")
    else:
        lines.append("  None found.")

    lines.append(f"\n── MISSING NAV TARGETS ({len(missing_nav)}) ─────────────────────────────────")
    lines.append("  (listed in mkdocs.yml but file does not exist on disk)")
    if missing_nav:
        for path in missing_nav:
            lines.append(f"  {path}")
    else:
        lines.append("  None found.")

    lines.append("\n" + "=" * 70)
    lines.append(f"SUMMARY: {len(stubs)} stubs, "
                 f"{len(orphaned_md)} orphaned files, "
                 f"{len(missing_nav)} missing nav targets.")
    lines.append("=" * 70)

    report = "\n".join(lines)
    print(report)
    REPORT_FILE.write_text(report, encoding="utf-8")
    print(f"\nFull report saved to: {REPORT_FILE.name}")


if __name__ == "__main__":
    main()
