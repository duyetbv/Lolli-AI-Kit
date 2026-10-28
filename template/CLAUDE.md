# CLAUDE.md – Lolli WordPress projects

@AGENTS.md

## Claude-specific

- Rules in `.claude/rules/*.md` load automatically (some only for matching paths). Follow them strictly.
- Before writing code, read the nearest `CLAUDE.md` (theme / plugin) and reuse existing helpers.
- For a new page section use the `lolli-new-section` skill; for a new post type `lolli-new-cpt`;
  from Figma `lolli-figma-to-wp`; before delivery `lolli-qa-checklist`; before launch `lolli-go-live`.
- After non-trivial changes, run the `lolli-code-reviewer` agent on the diff.
- Never print, copy or commit passwords / license keys. Point to the Rules xlsx instead.
- Ask before: installing/removing plugins, changing DB options on a shared/UAT site, any out-of-scope work.
- Reply to the team in Vietnamese when they write in Vietnamese; code, comments and commit messages in English.
