# CLAUDE.md – {{PROJECT}} theme (`{{theme}}`)

Project-wide rules: `AGENTS.md` and `.claude/rules/` at the repo root (Lolli standard). This file adds theme specifics.
If you opened only this folder, still follow those rules – summary at the bottom.

## Identity
| Item | Value |
|---|---|
| Theme | `{{theme}}` – classic PHP theme (no block theme, no build step unless stated below) |
| Prefix | functions/hooks `{{prefix}}_` · constants `{{PREFIX}}_` · handles/CSS `{{slug}}-` · text domain `{{slug}}` |
| Constants | `{{PREFIX}}_VERSION`, `{{PREFIX}}_DIR`, `{{PREFIX}}_URI` (defined in `functions.php`) |
| Design | `Project-Infomations/Design/` – Desktop 1440 / Mobile 393 + programming notes |
| Requires | ACF Pro, Contact Form 7, Polylang Pro (if multilingual) |

## Lolli base theme structure (where new code goes)
```
functions.php              only constants + ${{prefix}}_includes list – add new inc files here
inc/setup.php              theme supports, menus, image sizes ({{prefix}}_image_sizes()), redirects
inc/helpers.php            shared helpers – CHECK HERE BEFORE WRITING A NEW ONE
inc/icons.php              inline SVG icons → {{prefix}}_icon( 'name' )
inc/acf.php                field helpers {{prefix}}_f / _tab / _layout / _add_group, options page, acf-json paths
inc/fields/*.php           field groups (PHP = source; mirror in acf-json/)
inc/post-types.php         CPTs + taxonomies
inc/queries.php            query helpers
inc/rest.php               REST {{slug}}/v1 (AJAX lists)
inc/assets.php             enqueue, {{prefix}}_asset_ver(), CJK fonts by locale, font preload
inc/polylang.php           translatable CPTs/taxonomies + UI strings
inc/admin.php              admin columns, menus, comments off
page-templates/            template-sections.php (intro + flexible sections) + special templates
template-parts/sections/   one file per flexible-content layout (auto-rendered by sections.php)
template-parts/modules/    detail-page body blocks (auto-rendered by modules.php)
template-parts/components/ reusable cards/rows/modals/pagination
template-parts/header|footer/
assets/css/main.css        single stylesheet, tokens in :root, BEM (+ fonts*.css, editor.css)
assets/js/main.js          vanilla JS IIFE; page-specific JS only when large
assets/fonts/  assets/vendor/<lib>/   self-hosted fonts and pinned libraries
```

## Standard helpers (reuse, don't re-implement)
- Data: `{{prefix}}_field( $name, $post_id, $default )`, `{{prefix}}_option( $name, $default )`, `{{prefix}}_page_has_section()`.
- Images: `{{prefix}}_img( $id, '{{slug}}-card', $attr )`, `{{prefix}}_img_url()`, `{{prefix}}_image_id()`.
- Links/buttons: `{{prefix}}_button( $args )`, `{{prefix}}_link_button()`, `{{prefix}}_text_link()`, `{{prefix}}_link_parts()`.
- Headings/text: `{{prefix}}_section_head( $args )`, `{{prefix}}_label()`, `{{prefix}}_lines_to_list()`, `{{prefix}}_kses()`.
- Dates: `{{prefix}}_date_ts()`, `{{prefix}}_date()`, `{{prefix}}_today()` (Hong Kong timezone, `wp_date`).
- UI labels: `{{prefix}}_t( 'key' )` (registered with Polylang).
- Menus/breadcrumbs: `{{prefix}}_menu_id()`, `{{prefix}}_menu_tree()`, `{{prefix}}_breadcrumbs()`.
- Icons: `{{prefix}}_icon( 'name', 'class' )`.
> Legacy/different theme? Replace this list with the theme's real helpers.

## Theme conventions
- Section template: read `$args`, prefix locals `${{prefix}}_*`, `return` early if empty,
  wrapper `<section class="section <block><?php echo esc_attr( ${{prefix}}_bg ); ?>" data-reveal>` (`' section--light'` modifier).
- Image sizes: add to `{{prefix}}_image_sizes()` → `'{{slug}}-name' => array( w, h, crop, retina )`; ACF image labels show the size.
- ACF: edit PHP in `inc/fields/`, then sync `acf-json/` in the same commit (JSON wins over PHP if out of sync).
- JS config/strings come from `window.{{PREFIX}}` (via `wp_localize_script`).
- Keep theme `README.md` (setup + CMS map) updated when adding sections, fields or CPTs.

## Don't
- `get_field()` in templates · hardcoded text/URLs · inline style/script · Google Fonts/CDN · CSS-resized images ·
  jQuery (unless a plugin forces it) · hand-editing `acf-json/` · touching default themes.

## Project notes
<!-- Project-specific facts the AI must know: CPTs, special flows, URL params, page slugs, integrations, known gotchas. -->
- …

## Lolli rules summary (if root files are missing)
WPCS · escape late / sanitize early · nonce + capability on writes · everything CMS-editable · self-hosted, preloaded fonts
(Noto Sans TC/SC for Chinese) · licensed plugins only · English (US) backend, Hong Kong timezone, `/cmsadmin`, No Index until launch ·
Jira ticket per task, Bitbucket commits `{{JIRA}}-123: …`.
