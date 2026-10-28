---
name: lolli-new-cpt
description: Add a custom post type (and taxonomy) to a Lolli theme the standard way – registration, ACF fields, Polylang, admin columns, templates, REST/queries. Use when content needs its own list/detail type (events, resources, people, stores, promotions…).
---

# Add a custom post type

1. **Register** in `inc/post-types.php` inside `{{prefix}}_register_post_types()` using `{{prefix}}_cpt_labels( $singular, $plural )`:
   - key ≤ 20 chars, singular, prefixed only if generic (`event`, `resource`, `{{prefix}}_registration`).
   - `'show_in_rest' => true`, `'has_archive'` only if design has an archive, `'rewrite' => array( 'slug' => '…', 'with_front' => false )`,
     `'supports'` minimal, `'menu_icon'` dashicon, `'menu_position'` grouped with siblings.
   - Taxonomies registered in the same function, `'hierarchical' => true` for category-like, `'show_admin_column' => true`.
2. **Fields**: new file `inc/fields/<type>.php` (helpers `{{prefix}}_f`, `{{prefix}}_tab`, `{{prefix}}_add_group`), location rule post_type == type.
   Body content via the shared `modules` flexible content when the detail page is designed in blocks. Sync `acf-json/`.
3. **Polylang**: add to `{{prefix}}_pll_post_types()` / `{{prefix}}_pll_taxonomies()` (exclude private/system types).
4. **Admin UX**: columns (thumbnail, key dates, status), sortable columns, default order (`{{prefix}}_admin_order()`).
5. **Queries**: add query helpers in `inc/queries.php` (`{{prefix}}_<type>_*()`), `no_found_rows` when not paginated,
   transient cache if heavy. AJAX lists via `inc/rest.php` (`{{slug}}/v1/<route>` with `permission_callback` + sanitized args).
6. **Templates**: `single-<type>.php`, card component in `template-parts/components/<type>-card.php`.
7. **Images**: add needed sizes to `{{prefix}}_image_sizes()` in `inc/setup.php`.
8. Flush permalinks (`wp rewrite flush`), add demo data to the seeder, update README CMS map, test EN/zh.
