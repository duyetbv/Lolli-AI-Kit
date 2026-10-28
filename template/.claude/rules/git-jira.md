# Git / Bitbucket / Jira workflow

- Repo contains only custom code: `wp-content/themes/<project>/`, `wp-content/plugins/<project>-*/`, AI config
  (`AGENTS.md`, `CLAUDE.md`, `.claude/`, `phpcs.xml.dist`, `.editorconfig`).
  Never commit: core, third-party plugins, `uploads/`, `wp-config.php`, DB dumps, `Project-Infomations/`, `.DS_Store`, secrets.
- Branches: `feature/{{JIRA}}-123-short-desc`, `fix/{{JIRA}}-456-short-desc`, `hotfix/…`. Base: `develop`; release → `main`.
- Commit message: `{{JIRA}}-123: Imperative summary (≤72 chars)` + optional body explaining *why*.
- Small commits, one concern each. ACF PHP + `acf-json/` changes in the same commit.
- Pull request: link the Jira ticket, screenshots (desktop 1440 / mobile 393), test notes, PHPCS clean.
  At least one reviewer (or the `lolli-code-reviewer` agent for self-review before human review).
- Update the Jira ticket (status, time, notes) and post the daily update in the project group.
- Extra/out-of-scope work: separate Jira ticket marked *Change Request*, client approval before starting.
