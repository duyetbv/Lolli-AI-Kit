---
paths:
  - "wp-content/themes/**/assets/**"
  - "wp-content/themes/**/*.php"
---
# Front-end (CSS / JS)

## CSS
- One main stylesheet `assets/css/main.css` (+ `editor.css`, font CSS). Sections are separated by comment banners.
- Design tokens as CSS custom properties in `:root` (`--c-*` colours, `--f-*` fonts, `--gutter`, `--section`, `--radius`, `--t`).
  Never hardcode a colour/font that already exists as a token.
- **BEM** class names: `.block`, `.block__element`, `.block--modifier`. State classes: `.is-open`, `.is-active`, `.has-*`.
- JS hooks use `data-*` attributes (`[data-hero]`, `[data-modal-open]`), never styling classes.
- Desktop-first from the 1440 design; breakpoints consistent across the project (check existing `@media` values first).
- No `!important` (except utilities like `[hidden]`), no IDs for styling, no inline styles.
- Never scale images with CSS to fake a size – use the right registered image size (see images-fonts rule).
- Respect `prefers-reduced-motion`. Visible `:focus-visible` states.

## JavaScript
- Vanilla JS (ES5-compatible IIFE with `'use strict'`) in `assets/js/main.js`; page-specific files only when big
  (e.g. `register.js`, enqueued only on that template). jQuery only if a required plugin forces it.
- Follow the existing `jswindow` pattern / framework of the project if present.
- Config & translations from PHP via `wp_localize_script()` (`window.{{PREFIX}}`) – no URLs or strings hardcoded in JS.
- AJAX: REST API (`{{slug}}/v1`) for reads, `admin-ajax.php` / REST with nonce for writes.
- Third-party libs: pinned version, self-hosted in `assets/vendor/<lib>/` (e.g. Swiper 11.2.10). **No CDN.**

## Enqueue
- Only via `wp_enqueue_style/script` in `inc/assets.php`, version = `{{prefix}}_asset_ver()` (filemtime cache-bust).
- Scripts: `array( 'in_footer' => true, 'strategy' => 'defer' )`. Load page-specific assets conditionally.
