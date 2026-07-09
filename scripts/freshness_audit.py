#!/usr/bin/env python3
"""Audit deploy-strategy reference freshness and source coverage.

This script is intentionally offline. It does not verify that URLs are still
valid; it checks whether the knowledge base has the provenance structure needed
for a human or agent to perform live verification.
"""

from __future__ import annotations

import argparse
import datetime as dt
import re
from pathlib import Path


DATE_RE = re.compile(r"(?:Last research update|verified_at):\s*(\d{4}-\d{2}-\d{2})")
URL_RE = re.compile(r"https?://[^\s)>]+")
PLATFORM_ROW_RE = re.compile(r"^\|\s*([^|]+?)\s*\|\s*(https?://[^|]+)\|", re.MULTILINE)
URL_EXEMPT_FILES = {
    "19_auto_update_protocol.md",
    "20_platform_inventory.md",
    "21_research_and_refresh_workflow.md",
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Audit deploy-strategy references.")
    parser.add_argument(
        "skill_dir",
        nargs="?",
        default=".",
        help="Path to the deploy-strategy skill directory.",
    )
    parser.add_argument(
        "--max-age-days",
        type=int,
        default=30,
        help="Maximum acceptable age for pricing/freshness-sensitive files.",
    )
    return parser.parse_args()


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace")


def extract_dates(text: str) -> list[dt.date]:
    dates: list[dt.date] = []
    for match in DATE_RE.finditer(text):
        try:
            dates.append(dt.date.fromisoformat(match.group(1)))
        except ValueError:
            pass
    return dates


def main() -> int:
    args = parse_args()
    root = Path(args.skill_dir).resolve()
    refs = root / "references"
    manifest = refs / "00_source_manifest.md"

    failures: list[str] = []
    warnings: list[str] = []

    if not (root / "SKILL.md").exists():
        failures.append(f"Missing SKILL.md at {root}")
    if not refs.exists():
        failures.append(f"Missing references directory at {refs}")
    if not manifest.exists():
        failures.append("Missing references/00_source_manifest.md")

    today = dt.date.today()
    md_files = sorted(refs.glob("*.md")) if refs.exists() else []
    if len(md_files) < 20:
        warnings.append(f"Only {len(md_files)} reference files found; expected 20+ for v3 coverage.")

    stale_files: list[str] = []
    no_date_files: list[str] = []
    no_url_files: list[str] = []

    for path in md_files:
        text = read_text(path)
        dates = extract_dates(text)
        urls = URL_RE.findall(text)
        if not dates:
            no_date_files.append(path.name)
        else:
            newest = max(dates)
            if (today - newest).days > args.max_age_days:
                stale_files.append(f"{path.name} ({newest.isoformat()})")
        if path.name != "00_source_manifest.md" and path.name not in URL_EXEMPT_FILES and not urls:
            no_url_files.append(path.name)

    if no_date_files:
        warnings.append("Files without research/verification dates: " + ", ".join(no_date_files))
    if stale_files:
        warnings.append(
            f"Files older than {args.max_age_days} days: " + ", ".join(stale_files)
        )
    if no_url_files:
        warnings.append("Reference files without any source URLs: " + ", ".join(no_url_files))

    if manifest.exists():
        text = read_text(manifest)
        source_rows = PLATFORM_ROW_RE.findall(text)
        source_urls = URL_RE.findall(text)
        if len(source_rows) < 40:
            warnings.append(f"Manifest has only {len(source_rows)} platform source rows; target is 40+.")
        if len(source_urls) < 100:
            warnings.append(f"Manifest has only {len(source_urls)} URLs; target is 100+.")

    print("Deploy Strategy Freshness Audit")
    print(f"Skill dir: {root}")
    print(f"Reference files: {len(md_files)}")
    print()

    if failures:
        print("FAILURES")
        for item in failures:
            print(f"- {item}")
    else:
        print("FAILURES")
        print("- none")

    print()
    print("WARNINGS")
    if warnings:
        for item in warnings:
            print(f"- {item}")
    else:
        print("- none")

    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
