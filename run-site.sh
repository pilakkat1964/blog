#!/usr/bin/env bash
# Serve the published site only (no drafts).
# Cleans the build cache and output before serving.
set -euo pipefail

cd "$(dirname "$0")"

echo "==> Cleaning build cache and output..."
rm -rf .jekyll-cache _site

echo "==> Starting Jekyll (published posts only)..."
echo "==> Site will be available at http://localhost:4000"
bundle exec jekyll serve
