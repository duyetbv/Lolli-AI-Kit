# Multilingual (Polylang Pro)

- All PHP strings translatable with the project text domain (`{{slug}}` for the theme, `{{slug}}-<plugin>` for each custom plugin):
  `__()`, `_e()`, `esc_html__()`, `_x()` for context, `_n()` for plurals, `sprintf()` with placeholders + `/* translators: */` comment.
- UI labels managed by admins → register with `pll_register_string()` (see `inc/polylang.php`, `{{prefix}}_t()`).
- Every custom post type & taxonomy is added to Polylang's translatable list (`pll_get_post_types` / `pll_get_taxonomies` filters).
  Exclude private/system types (e.g. registrations).
- Always guard Polylang calls: `function_exists( 'pll_current_language' )`.
- Menus: one per language; theme falls back to the theme-mod menu (`{{prefix}}_menu_id()`).
- ACF options pages: translate per language when content differs.
- Forms: one CF7 form per language (CF7 Polylang extension). Emails in the visitor's language.
- Dates through `wp_date()` / `date_i18n()`; never hardcode English month names.
- Test every feature in EN + zh_HK + zh_CN before delivery.
