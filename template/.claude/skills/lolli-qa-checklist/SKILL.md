---
name: lolli-qa-checklist
description: Run the Lolli pre-delivery QA checklist on a WordPress site (versions, settings, plugins, CMS editability, images, fonts, SEO, security, forms, multilingual, code quality). Use before handing a build or UAT to the client.
---

# Lolli QA checklist

Run checks with WP-CLI where possible, report each item as ✅ / ❌ (+ fix) / ⚠️ (needs client).

## Automated
```bash
wp core version; wp core check-update
wp plugin list --fields=name,status,version,update
wp theme list --fields=name,status
wp option get blog_public          # must be 0 before launch
wp option get timezone_string      # Asia/Hong_Kong
wp option get WPLANG               # empty = en_US
wp post list --post_type=post,page --fields=ID,post_title,post_status
phpcs --standard=phpcs.xml.dist
grep -rn "fonts.googleapis\|fonts.gstatic\|cdn\." wp-content/themes/<theme> --include=*.php --include=*.css --include=*.js
grep -rn "style=\"" wp-content/themes/<theme>/template-parts | grep -v -- "--"
```

## Checklist
- [ ] Latest WordPress & plugins; only genuine licensed plugins; no unused plugins/themes
- [ ] No Index enabled (non-production)
- [ ] Timezone Hong Kong, backend English (US)
- [ ] Admin URL `/cmsadmin`, Stop User Enumeration active, security plugin configured
- [ ] Hello World / Sample Page / unused pages & posts removed
- [ ] Every section, banner, CTA, menu, footer, SEO field, image editable in CMS (spot-check each template)
- [ ] Images: proper registered sizes, srcset, Imagify active, no CSS-scaled images
- [ ] Fonts self-hosted + preloaded; Noto Sans TC/SC on Chinese locales; no Google Fonts requests
- [ ] Yoast configured (titles, OG, sitemap); WP Rocket configured
- [ ] Contact Form 7 sends (admin + auto-reply), reCAPTCHA, per language
- [ ] Multilingual: all pages/menus/strings/forms translated, language switcher works
- [ ] No PHP notices with `WP_DEBUG`, no JS console errors
- [ ] Desktop 1440 / tablet / mobile 393 match design; Chrome, Safari, Firefox, Edge
- [ ] Lighthouse: performance & accessibility checked
- [ ] Source on Bitbucket, Jira updated, daily update posted, extra work approved
