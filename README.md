# Lolli AI Kit

One shared AI coding standard for **all Lolli (Lollimedia HK) WordPress projects** – so every developer and every
AI agent (Claude Code, Cursor, Codex, Copilot…) writes code the same way.

Source of truth for the rules: `Lolli - RULES_.xlsx` (Project-Infomations/Rules) + the org skill *WordPress Client Development Standard*.

## What gets installed into a project

| Path (repo root = WordPress docroot) | Purpose | Updated by re-run? |
|---|---|---|
| `AGENTS.md` | Main instructions for all AI tools | yes |
| `CLAUDE.md` | Claude entry point (imports AGENTS.md) | yes |
| `.claude/rules/*.md` | Lolli standard, PHP/WP, security, ACF/CMS, front-end, images/fonts, Polylang, Git/Jira | yes |
| `.claude/skills/*/SKILL.md` | wp-setup, new-section, new-cpt, figma-to-wp, qa-checklist, go-live | yes |
| `.claude/agents/*.md` | code-reviewer, acf-architect, qa-tester | yes |
| `.claude/settings.json` | blocks editing core/3rd-party plugins/wp-config; asks before risky WP-CLI/git | yes |
| `phpcs.xml.dist`, `.editorconfig` | enforced WPCS style, prefix & text-domain checks | yes |
| `wp-content/themes/<theme>/CLAUDE.md` | theme specifics + **Project notes** | only if missing (`--force`) |
| `wp-content/plugins/<prefix>-*/CLAUDE.md` | plugin specifics + **Project notes** | only if missing (`--force`) |

## Install / update

```bash
./setup.sh --root "/Users/<you>/Local Sites/<site>/app/public" \
  --project "Times Square Mall" --prefix tsm \
  [--theme tsm] [--jira TSM] [--url http://tsm.local]
```

- `--prefix` drives everything: `tsm_` functions, `TSM_` constants, `tsm-` handles/text domain, `tsm-*` custom plugins.
- Re-run after the kit changes to pull the latest rules into a project. Project-specific knowledge belongs
  **only** in the theme/plugin `CLAUDE.md` → "Project notes" (never edit the shared rules per project –
  change the kit instead and re-run everywhere).
- Then commit the files to the project repo (`<JIRA>-xxx: Add Lolli AI Kit vX`).

## Rules for maintaining the kit

- Keep this kit in its own Bitbucket repo (e.g. `lolli/lolli-ai-kit`); bump `VERSION` on every change.
- Placeholders in `template/`: `{{PROJECT}} {{prefix}} {{PREFIX}} {{slug}} {{theme}} {{JIRA}} {{URL}} {{PLUGIN}}`.
- **Never** put passwords or licence keys in the kit or in projects – reference the Rules xlsx / password manager.
- Scope today: WordPress. OpenCart rules exist in the xlsx but are not in the kit yet.
