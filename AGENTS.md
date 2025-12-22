# Repository Guidelines

## Project Structure & Module Organization

- `content/` holds Hugo content. `content/docs/` is the main knowledge base (left nav), `content/posts/` is blog-style posts.
- `static/` contains static assets served as-is (e.g., `static/attachments/`).
- `layouts/` and `assets/` customize templates and styles.
- `themes/hugo-book/` is the Hugo Book theme submodule.
- `hugo.toml` is the site configuration; `vercel.json` configures hosting.
- Sync source-of-truth content from Obsidian via `deploy.sh` (see `OBSIDIAN_SETUP.md`).

## Build, Test, and Development Commands

- `hugo server -D` runs the local dev server including drafts at `http://localhost:1313`.
- `hugo --minify` builds a production-ready site to `public/`.
- `./deploy.sh` syncs Obsidian content → Hugo, commits, and pushes (also updates theme submodule if dirty).
- `./push.sh "message"` pushes local changes without Obsidian sync.

## Coding Style & Naming Conventions

- Use Markdown with YAML/TOML front matter; prefer explicit `title` and `weight`.
- Each section folder should include `_index.md` to define titles and menu behavior.
- For ordering, use numeric prefixes on folders (e.g., `01-intro/`) and `weight` for pages.
- Keep filenames lowercase with hyphens: `getting-started.md`, `2024-12-23-my-post.md`.

## Testing Guidelines

- No automated test suite is configured. Validate by running `hugo server -D` and checking navigation, links, and assets.

## Commit & Pull Request Guidelines

- Commit messages in this repo are timestamped, e.g., `Update: YYYY-MM-DD HH:MM:SS`, `Theme update: YYYY-MM-DD HH:MM:SS`, or `Site update: ...`.
- Prefer small, focused commits; include the script-generated format when using `deploy.sh` or `push.sh`.
- PRs should describe content changes, note any theme modifications, and include screenshots for layout or styling updates.

## Deployment & Content Sync Notes

- `deploy.sh` expects Obsidian content under `LifeOS/6. Website/2.hugo_books` and attachments in `LifeOS/6. Website/attachments`.
- If those paths differ locally, update the variables at the top of `deploy.sh`.
