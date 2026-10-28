# AGENTS.md – {{PROJECT}} (Lolli WordPress standard)

Shared instructions for every AI coding agent (Claude Code, Cursor, Codex, Copilot…) and every developer
working on Lolli (Lollimedia, HK) WordPress projects. Generated from **Lolli AI Kit** – the same rules for all
Lolli projects; only the values in the table below change per project.

> If a request conflicts with these rules, STOP and ask (client approval is required for exceptions).

## Project

| Item | Value |
|---|---|
| Project | {{PROJECT}} |
| Client | Lollimedia (HK) |
| Stack | WordPress latest stable, PHP 8.0+, classic theme, ACF Pro, Polylang Pro, CF7 |
| Local URL | {{URL}} |
| Prefix | PHP `{{prefix}}_` · constants `{{PREFIX}}_` · handles/CSS/text domain `{{slug}}` |
| Theme | `wp-content/themes/{{theme}}/` |
| Custom plugins | `wp-content/plugins/{{slug}}-*/` |
| Jira key | `{{JIRA}}` |
| Project docs | `Project-Infomations/` (Design, Docs, Rules, Database) – **never commit** |
| Tracking | Jira (every task/bug/CR has a ticket) · Bitbucket (source) · daily update in project group |

Only edit code under the theme and custom plugins above.
Never edit WordPress core (`wp-admin/`, `wp-includes/`) or third-party plugins.

Helper names in the rules (`{{prefix}}_field()`, `{{prefix}}_img()`, …) are the **Lolli base theme** helper set.
If this project's theme is legacy/different, the theme `CLAUDE.md` lists the real helpers – that file wins.

## Golden rules (short version)

1. **Everything is editable in the CMS.** No hardcoded text, images, links, CTA, menus, footer. Use ACF Flexible Content sections / options page.
2. **Security by default.** Escape late, sanitize early, nonce + capability on every write, `$wpdb->prepare()` always.
3. **Prefix everything** with the project prefix (`{{prefix}}_`, `{{PREFIX}}_`, `{{slug}}-`, text domain `{{slug}}`).
4. **WordPress APIs first** – no hardcoded URLs, no inline CSS/JS, no CDN, no Google Fonts.
5. **Images:** registered image sizes (1x + 2x), `wp_get_attachment_image()`; never resize/crop with CSS.
6. **Fonts:** self-hosted woff2 + preload. Chinese: Noto Sans TC (zh_HK/zh_TW), Noto Sans SC (zh_CN).
7. **Translation-ready:** every string through `__()`/`esc_html__()` etc.; Polylang for content + strings.
8. **Reuse before you write.** Check `inc/helpers.php`, `template-parts/components/` before adding new code.
9. **Licensed plugins only.** Never install nulled/cracked plugins. Never use AHT internal data/assets/credentials.
10. **No secrets in Git.** Credentials and license keys live in `Project-Infomations/Rules/Lolli - RULES_.xlsx` / password manager only.

## Where the detailed rules live

| Topic | File |
|---|---|
| Lolli process, plugins, backend config | `.claude/rules/00-lolli-standard.md` |
| PHP / WordPress coding | `.claude/rules/php-wordpress.md` |
| Security | `.claude/rules/security.md` |
| ACF & CMS structure | `.claude/rules/acf-cms.md` |
| CSS / JS | `.claude/rules/frontend.md` |
| Images & fonts | `.claude/rules/images-fonts.md` |
| Multilingual (Polylang) | `.claude/rules/i18n-polylang.md` |
| Git / Jira workflow | `.claude/rules/git-jira.md` |
| Theme specifics | `wp-content/themes/{{theme}}/CLAUDE.md` |
| Plugin specifics | `wp-content/plugins/{{slug}}-*/CLAUDE.md` |

Skills (step-by-step playbooks) – `.claude/skills/`:
`lolli-wp-setup`, `lolli-new-section`, `lolli-new-cpt`, `lolli-figma-to-wp`, `lolli-qa-checklist`, `lolli-go-live`.

Agents (sub-agents) – `.claude/agents/`:
`lolli-code-reviewer`, `lolli-acf-architect`, `lolli-qa-tester`.

## Commands

```bash
# Local → "Open site shell" (WP-CLI available)
wp core version && wp plugin list --fields=name,status,version,update
wp option get timezone_string     # Asia/Hong_Kong
wp option get blog_public         # 0 until launch

# Coding standard (composer global require wp-coding-standards/wpcs)
phpcs  --standard=phpcs.xml.dist
phpcbf --standard=phpcs.xml.dist
php -l <file>
```

## Definition of done

Code passes PHPCS (WordPress standard) · works with Polylang EN/zh · CMS-editable · tested desktop 1440 + mobile 393 ·
no PHP notices with `WP_DEBUG` on · Jira updated · committed to Bitbucket with the Jira key.
