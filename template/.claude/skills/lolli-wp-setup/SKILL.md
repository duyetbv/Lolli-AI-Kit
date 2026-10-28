---
name: lolli-wp-setup
description: Set up a new Lolli WordPress site (local/UAT) to the Lolli standard – install, backend config, standard plugin set, theme skeleton. Use when starting a new Lolli/mall WordPress project or auditing an install.
---

# New Lolli WordPress site

1. **Install** latest stable WordPress. Install email = standard project email.
2. **Backend config** (WP-CLI):
   ```bash
   wp language core install en_US --activate
   wp option update timezone_string 'Asia/Hong_Kong'
   wp option update blog_public 0                       # No Index / No Follow until launch
   wp rewrite structure '/%postname%/' --hard
   wp post delete 1 2 --force                          # Hello World + Sample Page
   wp theme delete twentytwentythree twentytwentyfour   # keep one default theme as fallback
   ```
3. **Admin user**: Lolli admin email from `Project-Infomations/Rules/Lolli - RULES_.xlsx` (never commit the password).
4. **Plugins** – genuine licensed packages only (ask the client if missing). See `.claude/rules/00-lolli-standard.md`:
   Yoast SEO, WP Rocket, Imagify, Solid Security, Stop User Enumeration, Contact Form 7 (+ Polylang ext.),
   Polylang Pro, ACF Pro, SVG Support, WP Upload Restriction, Duplicator Pro.
   Activate licences with keys from the Rules xlsx – do not paste keys into code or chat logs.
5. **Security**: Solid Security → Hide Backend → `cmsadmin`; Stop User Enumeration on; CF7 reCAPTCHA.
6. **Polylang**: EN default + required languages (zh_HK, zh_CN…), URL as directory, translate menus.
7. **Theme skeleton** – copy the Lolli base theme structure (reference: the latest Lolli project theme):
   ```
   functions.php  style.css  README.md  CLAUDE.md
   inc/{setup,helpers,icons,post-types,acf,queries,assets,rest,admin,polylang}.php  inc/fields/*.php
   acf-json/  page-templates/  template-parts/{header,footer,sections,modules,components}/
   assets/{css,js,fonts,vendor}/
   ```
   Rename the reference project's prefix → `{{prefix}}` / `{{PREFIX}}` / `{{slug}}` everywhere (functions, constants, text domain, handles).
   Then install Lolli AI Kit (`setup.sh`) so AGENTS.md / CLAUDE.md / rules / skills / agents / phpcs match this project.
8. Self-host fonts (incl. Noto Sans TC/SC) + preload. No Google Fonts.
9. Remove unused pages, posts, plugins, themes. Run the `lolli-qa-checklist` skill.
