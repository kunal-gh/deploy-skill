#!/usr/bin/env python3
"""Report seed-source platform coverage for deploy-strategy.

This script is intentionally offline. It verifies that important products from
the user's original 10-source prompt are visible in the manifest, inventory, and
evidence/completion references so future research gaps are explicit.
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True)
class Product:
    name: str
    required: bool = True
    aliases: tuple[str, ...] = ()


CORE_PRODUCTS = [
    Product("Vercel"),
    Product("Northflank"),
    Product("Netlify"),
    Product("AWS Amplify", aliases=("Amplify",)),
    Product("Google Cloud Run", aliases=("Cloud Run",)),
    Product("Heroku"),
    Product("Render"),
    Product("DigitalOcean App Platform", aliases=("DigitalOcean",)),
    Product("Cloudflare Pages", aliases=("Cloudflare",)),
    Product("Cloudflare Workers", aliases=("Workers",)),
    Product("Azure Static Web Apps"),
    Product("Firebase Hosting", aliases=("Firebase",)),
    Product("Tiiny Host"),
    Product("Railway"),
    Product("Fly.io", aliases=("Fly",)),
    Product("Koyeb"),
    Product("Zerops"),
    Product("Sliplane"),
    Product("Qovery"),
    Product("Bunnyshell"),
    Product("Coolify"),
    Product("Dokploy"),
    Product("Appwrite"),
    Product("Dokku"),
    Product("Juno"),
    Product("Kamal"),
    Product("SST", aliases=("SST Ion",)),
    Product("Jenkins"),
    Product("AWS Lambda", aliases=("Lambda",)),
    Product("Kinsta"),
    Product("Bunny CDN", aliases=("bunny.net", "Bunny")),
    Product("Cloudways"),
    Product("CircleCI"),
]


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Report deploy-strategy coverage.")
    parser.add_argument(
        "skill_dir",
        nargs="?",
        default=".",
        help="Path to the deploy-strategy skill directory.",
    )
    return parser.parse_args()


def read_lower(path: Path) -> str:
    if not path.exists():
        return ""
    return path.read_text(encoding="utf-8", errors="replace").lower()


def present(product: Product, text: str) -> bool:
    names = (product.name, *product.aliases)
    return any(name.lower() in text for name in names)


def mark(value: bool) -> str:
    return "yes" if value else "no"


def main() -> int:
    args = parse_args()
    root = Path(args.skill_dir).resolve()
    refs = root / "references"

    manifest = read_lower(refs / "00_source_manifest.md")
    inventory = read_lower(refs / "20_platform_inventory.md")
    evidence = read_lower(refs / "23_verified_evidence_original_prompt.md")
    completion = read_lower(refs / "24_seed_source_completion_matrix.md")
    all_refs = "\n".join(read_lower(path) for path in sorted(refs.glob("*.md")))

    failures: list[str] = []
    warnings: list[str] = []

    required_files = [
        refs / "00_source_manifest.md",
        refs / "20_platform_inventory.md",
        refs / "21_research_and_refresh_workflow.md",
        refs / "23_verified_evidence_original_prompt.md",
        refs / "24_seed_source_completion_matrix.md",
    ]
    for path in required_files:
        if not path.exists():
            failures.append(f"Missing {path.relative_to(root)}")

    rows: list[tuple[str, bool, bool, bool, bool]] = []
    for product in CORE_PRODUCTS:
        in_manifest = present(product, manifest)
        in_inventory = present(product, inventory)
        in_evidence = present(product, evidence)
        in_completion = present(product, completion)
        in_any_ref = present(product, all_refs)
        rows.append((product.name, in_manifest, in_inventory, in_evidence, in_completion))

        if product.required and not in_any_ref:
            failures.append(f"{product.name}: missing from all references")
        if product.required and not in_completion:
            failures.append(f"{product.name}: missing from seed completion matrix")
        if product.required and not (in_manifest or in_inventory or in_evidence):
            warnings.append(f"{product.name}: present only in completion matrix")

    print("Deploy Strategy Coverage Report")
    print(f"Skill dir: {root}")
    print()
    print("Product coverage")
    print("Product | manifest | inventory | evidence | completion")
    print("--- | --- | --- | --- | ---")
    for name, in_manifest, in_inventory, in_evidence, in_completion in rows:
        print(
            f"{name} | {mark(in_manifest)} | {mark(in_inventory)} | "
            f"{mark(in_evidence)} | {mark(in_completion)}"
        )

    print()
    print("FAILURES")
    if failures:
        for item in failures:
            print(f"- {item}")
    else:
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

