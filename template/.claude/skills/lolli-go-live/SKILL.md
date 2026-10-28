---
name: lolli-go-live
description: Lolli live-site launch checklist for WordPress (Duplicator migration, SSL, indexing, analytics, URL replacement, forms, SMTP, test data cleanup, cron). Use when moving a UAT site to production.
---

# Go-live (from "Live Site WP" sheet)

Confirm with the client before each irreversible step. Back up first (Duplicator Pro package of UAT + live).

1. Migrate with **Duplicator (Pro)** – package UAT, install on live.
2. **SSL** on, force HTTPS.
3. **Indexing**: untick *Discourage search engines* (`wp option update blog_public 1`), Yoast sitemap, submit to Google Search Console.
4. **Google Analytics / GTM** code – ask Lolli for the ID if not provided.
5. Replace all UAT/local URLs: `wp search-replace 'https://uat.example' 'https://www.example' --all-tables --precise --dry-run` then without `--dry-run`.
6. Contact Form 7: recipient, sender name/email, URLs per language.
7. Live admin: Lolli admin account, `/cmsadmin`, remove dev/test users.
8. Remove test data: demo-content plugin, test registrations/orders/customers, CF7 test entries, test uploads (e.g. payment proofs).
9. **Email**: test sending; SMTP configured with the client's mail settings (SPF/DKIM).
10. Real cron if required (`DISABLE_WP_CRON` + server cron).
11. WP Rocket cache warm-up, Imagify bulk optimize, Solid Security final config.
12. Run `lolli-qa-checklist` on live (except No Index → now Index), update Jira + group.
