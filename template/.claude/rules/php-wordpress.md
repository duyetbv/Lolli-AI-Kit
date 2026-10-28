---
paths:
  - "wp-content/themes/**/*.php"
  - "wp-content/plugins/**/*.php"
---
# PHP / WordPress coding rules

Follow **WordPress Coding Standards** (WPCS). Must pass `phpcs --standard=phpcs.xml.dist`.

## Files
- Every PHP file starts with a docblock (`@package {{PREFIX}}`) then `defined( 'ABSPATH' ) || exit;`.
- Tabs for indentation, spaces inside parentheses: `if ( $x ) {`, `array( 'a' => 1 )` (long array syntax).
- Yoda conditions: `if ( 'open' === $status )`. Strict comparison `===`, `in_array( $v, $list, true )`.
- One responsibility per file in `inc/` (setup, helpers, post-types, acf, queries, assets, rest, admin…).
  New file → add it to the `${{prefix}}_includes` list in `functions.php`.

## Naming
- Functions/hooks/options/meta/transients: `{{prefix}}_snake_case`. Constants: `{{PREFIX}}_UPPER`. Handles/CSS: `{{slug}}-kebab`.
- Global variables in templates must be prefixed: `${{prefix}}_items`, never `$items`.
- Hook callbacks are named functions, registered right below the function:
  ```php
  function {{prefix}}_register_post_types() { … }
  add_action( 'init', '{{prefix}}_register_post_types' );
  ```
- Classes only when they hold state (`class-{{slug}}-importer.php` → `{{PREFIX}}_Importer`).

## Docblocks
Every function has a docblock with description, `@param` (type + name) and `@return`.

## Templates
- Logic in `inc/`, markup in `template-parts/`. Templates only prepare simple variables and output.
- Pass data with `get_template_part( 'template-parts/sections/hero', null, $args )`; read from `$args`.
- Return early when required data is empty: `if ( ! ${{prefix}}_slides ) { return; }`.
- Alternative syntax in templates: `<?php if ( … ) : ?> … <?php endif; ?>`, `foreach : endforeach`.

## Data access
- ACF via theme wrappers (`{{prefix}}_field()`, `{{prefix}}_option()`), never raw `get_field()` in templates –
  wrappers keep the site working when ACF is inactive.
- Use `WP_Query` / `get_posts()` with `'no_found_rows' => true` when not paginating,
  `'fields' => 'ids'` when only IDs are needed. Never `query_posts()`.
- Direct SQL only through `$wpdb->prepare()`. Cache expensive queries in transients, flush on `save_post`.

## Avoid
- Hardcoded URLs/paths → `home_url()`, `get_permalink()`, `get_template_directory_uri()`, `rest_url()`, `admin_url()`.
- Inline `<style>`/`<script>` and `style=""` (exception: CSS custom property from CMS, e.g. `style="--bg:#fff"`, escaped).
- Duplicate logic – extract to a helper.
- `extract()`, `eval()`, `@` error suppression, `$_REQUEST`, short PHP tags, `die()` (use `wp_die()`).
- Output in `functions.php`/`inc/` files (no closing `?>` at end of pure-PHP files).
