---
name: lolli-new-section
description: Add a new CMS-editable page section (ACF Flexible Content layout) to a Lolli theme – fields, template part, CSS, JS, demo data, docs. Use whenever a design needs a new block/section on a page.
---

# Add a page section

Check first: can an existing section be reused with a new option/modifier? (`template-parts/sections/`). Prefer that.

1. **Name it**: layout `snake_case` (e.g. `logo_wall`) → template `template-parts/sections/logo-wall.php`, CSS block `.logo-wall`.
2. **Fields** – in `inc/fields/sections.php` add to `${{prefix}}_layouts`:
   ```php
   {{prefix}}_layout(
   	'logo_wall',
   	__( 'Logo wall', '{{slug}}' ),
   	array(
   		${{prefix}}_label,
   		${{prefix}}_title,
   		{{prefix}}_f( 'gallery', 'logos', __( 'Logos (400×200)', '{{slug}}' ) ),
   		${{prefix}}_bg,
   	)
   ),
   ```
   Every text/image/link editable. Image labels state the size. Use helpers – no manual field keys.
3. **Image size** (if new): add an entry to `{{prefix}}_image_sizes()` (`'{{slug}}-logo' => array( 400, 200, false, true )` –
   last flag registers the `-2x` retina size). Never `add_image_size()` elsewhere.
4. **Template** `template-parts/sections/logo-wall.php`:
   ```php
   <?php
   /**
    * Logo wall section.
    *
    * @package {{PREFIX}}
    */

   defined( 'ABSPATH' ) || exit;

   ${{prefix}}_logos = isset( $args['logos'] ) ? (array) $args['logos'] : array();
   if ( ! ${{prefix}}_logos ) {
   	return;
   }
   ${{prefix}}_bg = isset( $args['background'] ) && 'light' === $args['background'] ? ' section--light' : '';
   ?>
   <section class="section logo-wall<?php echo esc_attr( ${{prefix}}_bg ); ?>" data-reveal>
   	<div class="container">
   		<?php {{prefix}}_section_head( $args ); ?>
   		…
   	</div>
   </section>
   ```
   Escape everything; reuse `{{prefix}}_img()`, `{{prefix}}_button()`, `{{prefix}}_section_head()`, components.
   The section is rendered automatically by `template-parts/sections/sections.php`.
5. **CSS** in `assets/css/main.css` under a comment banner, BEM, tokens only, desktop 1440 + mobile 393.
6. **JS** (only if interactive): `data-*` hook, add an init block in `main.js`; strings via `{{PREFIX}}.i18n`.
7. **Sync ACF JSON**: regenerate `acf-json/` from PHP (ACF → Field Groups → Sync, or re-save) – same commit.
8. **Demo data**: add the layout to the `{{slug}}-demo-content` seeder plugin (if the project has one) so QA sees it.
9. **Docs**: add a row to the CMS map in theme `README.md`; update the CMS user guide if client-facing.
10. **Verify**: PHPCS clean, empty-field states don't break, EN/zh languages, compare to Figma.
