# How to Maintain This Site

A practical reference for building, authoring, and deploying **Santhosh's Tech Notes** — a personal technology blog built with Jekyll and the Chirpy theme, hosted on GitHub Pages.

---

## Table of Contents

1. [Site Overview](#1-site-overview)
2. [Local Development Setup](#2-local-development-setup)
3. [Build & Preview Commands](#3-build--preview-commands)
4. [Writing Posts — Draft → Publish Workflow](#4-writing-posts--draft--publish-workflow)
5. [Post Front Matter Reference](#5-post-front-matter-reference)
6. [Blog Categories](#6-blog-categories)
7. [Managing Pages & Tabs](#7-managing-pages--tabs)
8. [Site Configuration (_config.yml)](#8-site-configuration-_configyml)
9. [Assets — Images & Media](#9-assets--images--media)
10. [Git & Deployment](#10-git--deployment)
11. [Troubleshooting](#11-troubleshooting)
12. [Useful References](#12-useful-references)
13. [Helper Scripts Reference](#13-helper-scripts-reference)

---

## 1. Site Overview

| Item | Detail |
|---|---|
| **Site title** | Santhosh's Tech Notes |
| **Theme** | [jekyll-theme-chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) ~> 7.5 |
| **Hosting** | GitHub Pages — auto-deployed on push to `main` |
| **Live URL** | https://pilakkat.freeddns.org (CNAME alias) |
| **GitHub repo** | https://github.com/proteus-cpi/proteus-cpi.github.io |
| **Ruby version** | 3.4.9 (managed via [mise](https://mise.jdx.dev/)) |
| **Bundler version** | 4.0.9 |
| **Timezone** | Asia/Singapore |

### Repository structure

```
.
├── _config.yml          # Master site configuration
├── _posts/              # Published posts (live on the site)
├── _drafts/             # Draft posts (local preview only)
├── _tabs/               # Sidebar navigation pages (About, Archives, etc.)
├── _data/
│   ├── contact.yml      # Sidebar contact icons
│   └── share.yml        # Post share buttons
├── assets/
│   └── img/
│       ├── avatar.jpg   # Sidebar profile photo
│       └── favicons/    # Favicon set
├── tools/
│   └── check-links.py   # Pre-publish link validator (Python)
├── run-site.sh          # Clean build + serve (published only)
├── run-draft-site.sh    # Clean build + serve (published + drafts)
├── SiteMaintenance.md   # This document (excluded from built site)
├── Gemfile              # Ruby gem dependencies
├── Gemfile.lock         # Locked gem versions (must be committed)
└── CNAME                # Custom domain mapping
```

---

## 2. Local Development Setup

### Prerequisites

- **mise** for Ruby version management — version is pinned in `mise.toml` (Ruby 3.4.9)
- **Bundler** for gem dependency management

### First-time setup

```bash
# Clone the repo
git clone https://github.com/proteus-cpi/proteus-cpi.github.io.git
cd proteus-cpi.github.io

# Activate the correct Ruby version via mise
mise install          # installs Ruby 3.4.9 if not already present

# Install gems
bundle install
```

### Important: Gemfile.lock and platforms

`Gemfile.lock` is committed to the repo (unlike many Jekyll setups). It must include `x86_64-linux` in its PLATFORMS section for the local build to work on Linux. If `bundle install` fails after a fresh clone, run:

```bash
bundle lock --add-platform x86_64-linux
bundle install
```

---

## 3. Build & Preview Commands

| Goal | Command |
|---|---|
| Build the site (published posts only) | `bundle exec jekyll build` |
| Build including drafts | `bundle exec jekyll build --drafts` |
| Serve locally — published only | `./run-site.sh` |
| Serve locally — include drafts | `./run-draft-site.sh` |
| Serve locally — include `published: false` posts | `bundle exec jekyll serve --unpublished` |
| Serve locally — show everything | `bundle exec jekyll serve --drafts --unpublished` |
| Clean build (wipe cache and output) | `rm -rf .jekyll-cache _site && bundle exec jekyll build` |
| Check for broken internal links | `python3 tools/check-links.py` |
| Check links + full htmlproofer validation | `python3 tools/check-links.py --htmlproofer` |

The local server runs at **http://localhost:4000** by default. Changes to `_config.yml` require a server restart; changes to posts are picked up automatically when using `--watch` (included by default with `serve`).

> **Tip:** Use `./run-site.sh` and `./run-draft-site.sh` — they always do a clean build first, avoiding stale cache issues.

---

## 4. Writing Posts — Draft → Publish Workflow

### Step 1 — Create a draft

Create a new file in `_drafts/`. The filename should be in the format `YYYY-MM-DD-slug.md`. Including the intended publication date in the filename is recommended — it preserves context even while the post is a draft.

```bash
# Example
touch _drafts/2026-05-01-my-new-post.md
```

Populate the front matter (see [Section 5](#5-post-front-matter-reference) for the full template).

### Step 2 — Preview locally

```bash
bundle exec jekyll serve --drafts
# Open http://localhost:4000
```

Drafts appear in the post list and category pages. They are **never** included in a normal `jekyll build` and are therefore never deployed to GitHub Pages.

### Step 3 — Iterate and refine

Edit the file, save — Jekyll will automatically regenerate the page in the browser (live-reload is enabled by default with `serve`).

### Step 4 — Pre-publish validation

Before moving a draft to `_posts/`, run the link checker to catch any internal links pointing to posts that are still drafts. The CI pipeline (`htmlproofer`) will reject such links and block deployment.

```bash
# Check for broken internal links and auto-fix them
python3 tools/check-links.py

# Full validation: fix links + clean build + htmlproofer (mirrors CI exactly)
python3 tools/check-links.py --htmlproofer
```

If `check-links.py` finds a link pointing to a draft post, it automatically replaces it with plain text:

```
[Embedded Rust on ARM Cortex-M](/posts/embedded-rust-getting-started/)
  →  Embedded Rust on ARM Cortex-M *(coming soon)*
```

Commit the auto-fixed files before pushing.

> **Why this matters:** GitHub Actions runs `htmlproofer` on every push. If a published post links to a URL that doesn't exist in the built site (e.g., a draft), the build fails and the site is not deployed. Running the checker locally catches this before CI does.

### Step 5 — Publish

When the post is ready and all links are valid, move it from `_drafts/` to `_posts/`:

```bash
git mv _drafts/2026-05-01-my-new-post.md _posts/
git add _posts/2026-05-01-my-new-post.md
git commit -m "Publish: My New Post Title"
git push
```

GitHub Actions picks up the push and redeploys the site within ~2 minutes.

### Temporarily hiding a published post

If you need to pull a post from the live site without deleting it:

```yaml
# In the post's front matter (inside _posts/)
published: false
```

Preview it locally with `bundle exec jekyll serve --unpublished`. Push the change to hide it from the live site. Reverse by removing the line or setting `published: true`.

---

## 5. Post Front Matter Reference

Every post begins with a YAML front matter block between `---` delimiters.

```yaml
---
title: "Your Post Title"
date: YYYY-MM-DD HH:MM:SS +0800        # +0800 = Asia/Singapore (SGT)
categories: [MainCategory, SubCategory] # See Section 6 for category list
tags: [tag1, tag2, tag3]                # Lowercase, hyphen-separated
description: "One-sentence SEO summary shown in search results and card previews."
image:
  path: /assets/img/posts/my-hero.jpg   # Optional hero image (1200×630 recommended)
  alt: "Alt text for the hero image"
pin: false                              # true = pin to top of home page
toc: true                               # Table of contents (default: true)
comments: false                         # Enable/disable comments (if configured)
math: false                             # Enable KaTeX for math rendering
mermaid: false                          # Enable Mermaid diagrams
published: true                         # Set false to hide from live site
---
```

### Chirpy callout / prompt blocks

```markdown
> This is a tip.
{: .prompt-tip }

> This is a note.
{: .prompt-info }

> This is a warning.
{: .prompt-warning }

> This is a danger/error callout.
{: .prompt-danger }
```

### Code blocks

````markdown
```rust
fn main() {
    println!("Hello, world!");
}
```
````

Syntax highlighting is automatic. Supported languages include `rust`, `c`, `cpp`, `python`, `bash`, `yaml`, `toml`, `verilog`, `diff`, and many more.

---

## 6. Blog Categories

Categories are defined purely by the `categories:` field in each post's front matter — no separate configuration files are needed. Chirpy auto-generates the **Categories** page from the posts.

Use the two-level format `[MainCategory, SubCategory]` for best organisation.

| Main Category | Sub-categories in use |
|---|---|
| **SDR** | Fundamentals, FPGA |
| **5G & Wireless** | Private Networks |
| **Industrial Automation** | TSN, Connectivity |
| **Embedded Systems** | Rust |
| **Programming** | Python |
| **Linux** | Kernel |
| **AI/ML** | Edge Inference |
| **3D Printing** | Electronics |

To add a new category simply use it in a post's front matter — it will appear automatically.

---

## 7. Managing Pages & Tabs

Static pages that appear in the left sidebar are stored in `_tabs/`:

```
_tabs/
├── about.md        # About page — edit this to update your bio
├── archives.md     # Auto-generated post archive (do not edit)
├── categories.md   # Auto-generated category listing (do not edit)
└── tags.md         # Auto-generated tag listing (do not edit)
```

To add a new sidebar tab, create a new `.md` file in `_tabs/` with this front matter:

```yaml
---
title: My New Tab
icon: fas fa-book   # FontAwesome 6 icon class
order: 6            # Position in the sidebar (lower = higher up)
---
```

---

## 8. Site Configuration (_config.yml)

Key settings and where to find them:

| Setting | Key in _config.yml | Notes |
|---|---|---|
| Site title | `title` | Shown in browser tab and sidebar |
| Subtitle | `tagline` | Shown below title in sidebar |
| SEO description | `description` | Used in meta tags and RSS feed |
| Live URL | `url` | Must match the CNAME/GitHub Pages URL |
| Avatar image | `avatar` | Path relative to site root |
| Light/dark mode | `theme_mode` | `light` or `dark`; leave blank for system default |
| Timezone | `timezone` | Affects post dates |
| GitHub username | `github.username` | Links sidebar GitHub icon |
| Author name | `social.name` | Used in copyright footer and structured data |
| Author email | `social.email` | Used in RSS feed |
| Social profile links | `social.links` | First entry = copyright owner link |
| Google Analytics | `analytics.google.id` | Add GA4 measurement ID here |
| Comments | `comments.provider` | Supports `disqus`, `utterances`, `giscus` |
| CDN prefix | `cdn` | Optional; prepend to all asset URLs |

After editing `_config.yml`, restart `jekyll serve` — it does not hot-reload.

---

## 9. Assets — Images & Media

### Profile photo (avatar)

- File: `assets/img/avatar.jpg`
- Referenced in `_config.yml` as `avatar: /assets/img/avatar.jpg`
- Recommended size: square, at least 200×200 px

### Post hero images

Store in `assets/img/posts/` (create the directory if needed):

```bash
assets/img/posts/my-post-hero.jpg
```

Reference in front matter:

```yaml
image:
  path: /assets/img/posts/my-post-hero.jpg
  alt: Descriptive alt text
```

Chirpy displays the hero image at the top of the post and as the Open Graph preview image for social sharing. Recommended dimensions: **1200 × 630 px**.

### Inline images in post body

```markdown
![Alt text](/assets/img/posts/diagram.png)
_Optional caption displayed below the image_
```

---

## 10. Git & Deployment

### Branching model

The repo uses a single `main` branch. All commits to `main` trigger the GitHub Actions workflow that builds and deploys to GitHub Pages.

### Typical commit workflow

```bash
# 1. Check what has changed
git status
git diff

# 2. Validate links and run htmlproofer (catches broken links before CI does)
python3 tools/check-links.py --htmlproofer

# 3. Stage and commit
git add _posts/2026-05-01-my-new-post.md
git commit -m "Publish: My New Post Title"

# 4. Push — triggers deployment
git push
```

### Deployment pipeline

1. Push to `main` on GitHub
2. GitHub Actions runs `.github/workflows/pages-deploy.yml`
3. Jekyll builds the site in CI (with the production URL)
4. Output is pushed to the `gh-pages` branch (or deployed directly via Pages API)
5. GitHub Pages serves from there — live within ~2 minutes

### Checking deployment status

```bash
gh run list --limit 5          # List recent workflow runs
gh run view <run-id>           # View a specific run's output
```

Or check directly at: https://github.com/proteus-cpi/proteus-cpi.github.io/actions

---

## 11. Troubleshooting

### Build fails: "Could not find gem X in locally installed gems"

**Cause:** `Gemfile.lock` PLATFORMS section is missing `x86_64-linux` — Bundler cannot match precompiled gems.

```bash
bundle lock --add-platform x86_64-linux
bundle install
```

### Build fails: LoadError — "linked to incompatible libruby-3.2.so"

**Cause:** Stale native extension `.so` files compiled against the system Ruby 3.2 are shadowing the correctly built extensions for mise Ruby 3.4.

```bash
gem pristine --all
# If specific gems (e.g. json, msgpack) still fail, copy the rebuilt .so
# from ~/.local/share/mise/installs/ruby/3.4.9/... extensions dir to the gem's lib/ dir
```

### Jekyll binary uses wrong Ruby version

**Cause:** Jekyll wrapper script has shebang `#!/usr/bin/env ruby3.2` from a previous install.

```bash
gem pristine jekyll    # regenerates wrapper with current Ruby
```

### Site shows "Chirpy" title or missing avatar after `jekyll serve`

**Cause:** Stale `_site/` or `.jekyll-cache/` from a previous build.

```bash
rm -rf .jekyll-cache _site
bundle exec jekyll serve
```

### CI build fails: "internally linking to /posts/X/, which does not exist"

**Cause:** A published post contains a Markdown link pointing to a post that is currently in `_drafts/` (and therefore not built in production). `htmlproofer` treats this as a broken link.

```bash
# Find and auto-fix all broken internal links
python3 tools/check-links.py

# Preview what would be changed without modifying files
python3 tools/check-links.py --dry-run
```

The script replaces `[label](/posts/missing-slug/)` with `label *(coming soon)*`. Commit the fixed files and push again.

### Drafts not showing locally

Use the `--drafts` flag — it is **not** the default:

```bash
bundle exec jekyll serve --drafts
```

### theme_mode not applying

Ensure the value is **inline** with the key in `_config.yml`:

```yaml
theme_mode: light    # ✅ correct
theme_mode:          # ❌ wrong — treated as null
  light
```

---

## 12. Useful References

| Resource | URL |
|---|---|
| Chirpy theme documentation | https://chirpy.cotes.page |
| Chirpy GitHub repository | https://github.com/cotes2020/jekyll-theme-chirpy |
| Jekyll official docs | https://jekyllrb.com/docs/ |
| Jekyll front matter defaults | https://jekyllrb.com/docs/configuration/front-matter-defaults/ |
| Jekyll posts documentation | https://jekyllrb.com/docs/posts/ |
| Liquid templating (used in layouts) | https://shopify.github.io/liquid/ |
| FontAwesome 6 icon search | https://fontawesome.com/icons |
| Mermaid diagram syntax | https://mermaid.js.org/intro/ |
| KaTeX math functions | https://katex.org/docs/supported.html |
| mise Ruby version manager | https://mise.jdx.dev/ |
| GitHub Pages documentation | https://docs.github.com/en/pages |
| YAML syntax reference | https://learnxinyminutes.com/docs/yaml/ |

---

## 13. Helper Scripts Reference

| Script | Purpose |
|---|---|
| `./run-site.sh` | Clean build + `jekyll serve` (published posts only) |
| `./run-draft-site.sh` | Clean build + `jekyll serve --drafts` (all posts) |
| `python3 tools/check-links.py` | Scan published posts for broken internal links; auto-fix |
| `python3 tools/check-links.py --dry-run` | Preview fixes without modifying any files |
| `python3 tools/check-links.py --htmlproofer` | Fix links + clean build + full htmlproofer validation |

### When to run each script

| Situation | Script to run |
|---|---|
| Writing / editing a draft | `./run-draft-site.sh` |
| Checking what the live site will look like | `./run-site.sh` |
| Before moving a draft to `_posts/` | `python3 tools/check-links.py` |
| Before every `git push` | `python3 tools/check-links.py --htmlproofer` |
| CI failed with htmlproofer error | `python3 tools/check-links.py --dry-run` to diagnose, then without `--dry-run` to fix |
