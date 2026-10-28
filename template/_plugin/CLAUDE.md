# CLAUDE.md – {{PLUGIN}} (Lolli custom plugin)

Project-wide rules: `AGENTS.md` and `.claude/rules/` at the repo root.

## This plugin
- Purpose: …  <!-- one line: what it does, who uses it -->
- Entry: `{{PLUGIN}}.php` · logic in `includes/` · assets in `assets/`.
- Text domain `{{PLUGIN}}` · prefix `{{prefix}}_` / `{{PREFIX}}_` (+ feature sub-prefix if useful).
- Dev/UAT only? If this is a demo/seed plugin: keep it **idempotent** (look up by slug/meta, update instead of duplicate)
  and **delete before launch** (`lolli-go-live` skill).

## Conventions for every Lolli custom plugin
- Folder/slug `{{slug}}-<feature>`, main file same name, header with Plugin Name, Description, Version,
  Author `Lollimedia`, Requires at least, Requires PHP 8.0, Text Domain.
- `defined( 'ABSPATH' ) || exit;` · constants `{{PREFIX}}_<FEATURE>_DIR/_URL/_VERSION` · one class or concern per file
  (`class-{{slug}}-<name>.php`) · no output on activation.
- Theme = presentation; plugin = functionality that must survive a theme change (integrations, data, cron, APIs).
- Admin screens: `current_user_can()` + nonce on every action. WP-CLI commands under `wp {{slug}} <cmd>`.
- Activation/deactivation hooks clean up (flush rewrite, unschedule cron); `uninstall.php` removes only the plugin's own data.
- Same WPCS / security / i18n rules as the theme; the plugin path + text domain are listed in `phpcs.xml.dist`.

## Project notes
- …
