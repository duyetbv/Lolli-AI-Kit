# Images & fonts

## Images
- **Do not resize or crop images with CSS.** Register exact sizes in `{{prefix}}_image_sizes()` (`inc/setup.php`)
  (1x + `-2x` retina variants, `{{slug}}-*` names) and output with `{{prefix}}_img()` / `wp_get_attachment_image()`
  so WordPress emits `srcset` + `sizes`.
- Always pass a correct `sizes` attribute; first above-the-fold image `loading="eager"` (+ `fetchpriority="high"`), rest lazy.
- `object-fit` is allowed only to keep aspect ratio inside a box of the same ratio – never as a substitute for a proper size.
- Alt text from the media library (fallback: title). Decorative images `alt=""`.
- Run Imagify on all uploads (WebP). After adding sizes: `wp media regenerate --only-missing`.
- SVG only via SVG Support plugin (sanitised) or inline icons from `inc/icons.php` (`{{prefix}}_icon()`).

## Fonts
- **Never load Google Fonts (or any font CDN).** Download woff2, put in `assets/fonts/`, declare `@font-face`
  with `font-display: swap` in `assets/css/fonts*.css`.
- **Preload** the critical weights (`<link rel="preload" as="font" type="font/woff2" crossorigin>` – see `{{prefix}}_preload_fonts()`).
- Chinese defaults: **Noto Sans TC** for Traditional (zh_HK / zh_TW), **Noto Sans SC** for Simplified (zh_CN).
  Load the CJK font CSS only for those locales (`{{prefix}}_cjk_font()`), subset if possible.
