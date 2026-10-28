# Security rules

- **Escape late** (at output): `esc_html()`, `esc_attr()`, `esc_url()`, `esc_textarea()`, `wp_kses_post()` /
  `{{prefix}}_kses()`, `wp_json_encode()`. Translatable output: `esc_html__()`, `esc_html_e()`, `esc_attr__()`.
  Helpers that return safe HTML (e.g. `{{prefix}}_img()`, `{{prefix}}_icon()`, `{{prefix}}_button()`) may be echoed with
  `// phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped` – document why.
- **Sanitize early** (at input): `sanitize_text_field( wp_unslash( $_POST['x'] ) )`, `sanitize_email()`,
  `absint()`, `sanitize_key()`, `esc_url_raw()`, `sanitize_textarea_field()`. Whitelist enums with `in_array( …, true )`.
- **Every write** (form, AJAX, admin action) = nonce (`wp_nonce_field` / `check_ajax_referer` / `check_admin_referer`)
  + capability check (`current_user_can()`). Public forms: nonce + honeypot/reCAPTCHA + rate limiting where needed.
- REST routes always declare `permission_callback` (`__return_true` only for public read endpoints) and `args` with
  `sanitize_callback` / `validate_callback`.
- Uploads: `wp_handle_upload()` with `mimes` whitelist + size limit; private files outside public access
  (protected folder + `.htaccess` deny, served via capability-checked handler).
- SQL only via `$wpdb->prepare()`.
- Never commit secrets (`wp-config.php`, keys, passwords, `.env`). Never log personal data.
- Stop User Enumeration + hide backend `/cmsadmin` on every site. Disable XML-RPC if not used.
