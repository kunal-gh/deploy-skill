#!/usr/bin/env python3
"""Verify official source URLs for deploy-strategy.

This script performs lightweight HTTP checks against source URLs embedded in the
knowledge base. Use --dry-run in offline/sandboxed environments to inspect what
would be checked without making network requests.
"""

from __future__ import annotations

import argparse
import csv
import datetime as dt
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path


URL_RE = re.compile(r"https?://[^\s)>|]+")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Verify deploy-strategy source URLs.")
    parser.add_argument(
        "skill_dir",
        nargs="?",
        default=".",
        help="Path to the deploy-strategy skill directory.",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="List URLs without making network requests.",
    )
    parser.add_argument(
        "--limit",
        type=int,
        default=0,
        help="Limit number of URLs checked; 0 means no limit.",
    )
    parser.add_argument(
        "--timeout",
        type=float,
        default=10.0,
        help="Per-request timeout in seconds.",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=None,
        help="Optional CSV output path.",
    )
    return parser.parse_args()


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace")


def collect_urls(root: Path) -> list[tuple[str, str]]:
    candidates = [root / "SKILL.md", root / "README.md"]
    refs = root / "references"
    if refs.exists():
        candidates.extend(sorted(refs.glob("*.md")))

    seen: set[str] = set()
    urls: list[tuple[str, str]] = []
    for path in candidates:
        if not path.exists():
            continue
        text = read_text(path)
        for match in URL_RE.finditer(text):
            url = match.group(0).rstrip(".,")
            if url in seen:
                continue
            seen.add(url)
            urls.append((str(path.relative_to(root)), url))
    return urls


def check_url(url: str, timeout: float) -> tuple[str, str]:
    request = urllib.request.Request(
        url,
        method="HEAD",
        headers={"User-Agent": "deploy-strategy-source-verifier/1.0"},
    )
    try:
        with urllib.request.urlopen(request, timeout=timeout) as response:
            return str(response.status), response.reason
    except urllib.error.HTTPError as error:
        if error.code in {403, 405}:
            return check_url_get(url, timeout)
        return str(error.code), error.reason
    except Exception as error:  # noqa: BLE001 - CLI should report all URL failures.
        return "ERROR", str(error)


def check_url_get(url: str, timeout: float) -> tuple[str, str]:
    request = urllib.request.Request(
        url,
        method="GET",
        headers={"User-Agent": "deploy-strategy-source-verifier/1.0"},
    )
    try:
        with urllib.request.urlopen(request, timeout=timeout) as response:
            return str(response.status), response.reason
    except urllib.error.HTTPError as error:
        return str(error.code), error.reason
    except Exception as error:  # noqa: BLE001
        return "ERROR", str(error)


def main() -> int:
    args = parse_args()
    root = Path(args.skill_dir).resolve()
    urls = collect_urls(root)
    if args.limit > 0:
        urls = urls[: args.limit]

    rows: list[dict[str, str]] = []
    for source_file, url in urls:
        if args.dry_run:
            status, reason = "DRY_RUN", "not checked"
        else:
            status, reason = check_url(url, args.timeout)
        rows.append(
            {
                "checked_at": dt.datetime.now(dt.UTC).isoformat(timespec="seconds"),
                "source_file": source_file,
                "url": url,
                "status": status,
                "reason": reason,
            }
        )
        print(f"{status:>7} {url} ({source_file})")

    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        with args.output.open("w", encoding="utf-8", newline="") as handle:
            writer = csv.DictWriter(
                handle,
                fieldnames=["checked_at", "source_file", "url", "status", "reason"],
            )
            writer.writeheader()
            writer.writerows(rows)

    failures = [row for row in rows if row["status"] == "ERROR" or row["status"].startswith("5")]
    return 1 if failures and not args.dry_run else 0


if __name__ == "__main__":
    raise SystemExit(main())
