---
paths:
  - "wp-content/themes/**/inc/**"
  - "wp-content/themes/**/acf-json/**"
  - "wp-content/themes/**/template-parts/**"
---
# ACF & CMS structure

## Principle
Every visible text/image/link is editable. A designer's page = a stack of reusable **sections**
(ACF Flexible Content field `sections`) that admins can add, remove and re-order. Detail pages (CPT)
use a `modules` flexible content for the body.

## Field groups
- Source of truth: PHP definitions in `inc/fields/*.php`, built with the helpers in `inc/acf.php`:
  `{{prefix}}_f( $type, $name, $label, $extra )`, `{{prefix}}_tab()`, `{{prefix}}_layout()`, `{{prefix}}_add_group()`.
  Keys are deterministic (generated from the path) – never hand-write `field_xxx` keys.
- `acf-json/` is a mirror for ACF UI sync. **JSON overrides PHP**: when you change PHP fields,
  regenerate/sync `acf-json/` in the same commit. Never edit fields only in the WP admin.
- Return formats: image/gallery/file → **ID**; link → **array**; relationship/post_object → **ID**.
- Image field labels include the required size, e.g. `Image (2880×1400)`.
- Use `wrapper width` (50/33/25) and tabs to keep the editor tidy; add `instructions` for non-obvious fields.
- Global content (logo, footer, socials, contact, emails, 404 texts) → **Site settings** options page (`{{prefix}}_option()`).

## Section conventions
- Layout name `snake_case` (`featured_event`) ↔ template `template-parts/sections/featured-event.php`
  (rendered automatically by `template-parts/sections/sections.php`).
- Common section fields: `label`, `title`, `background` (white / light) – reuse the shared field variables.
- Every new section also gets: CSS block in `main.css`, demo data in the demo-content plugin (if any), a line in the CMS map in `README.md`.

## Hardcoding
Not allowed for content. Allowed only for UI micro-labels, and those go through `{{prefix}}_t( 'key' )`
(registered as Polylang strings) so they are still translatable.
