# Lolli WordPress standard (mandatory)

Source: `Project-Infomations/Rules/Lolli - RULES_.xlsx`. Exceptions need written client approval.

## Process
- Never use AHT internal information, assets, source code, test data or credentials.
- Jira for every task, bug, change request and extra work. No ticket → no work.
- Bitbucket for source code. Always push.
- Post a daily progress update in the project group.
- Out-of-scope work: get client confirmation **before** starting.
- Admin account: the Lolli admin email (see Rules xlsx). Never commit the password.

## Install
- Latest stable WordPress, latest plugin versions.
- Backend language **English (United States)**, timezone **Hong Kong** (`Asia/Hong_Kong`).
- Use the standard project email for install, backend config and front-end testing.
- **No Index / No Follow** (Settings → Reading → Discourage search engines) until launch.
- Admin URL **`/cmsadmin`** (Solid/iThemes Security → Hide Backend).
- Remove Hello World, Sample Page, unused pages/posts/plugins/themes.

## Standard plugin set (genuine licences only – ask the client for packages/keys)
| Purpose | Plugin |
|---|---|
| SEO | Yoast SEO |
| Cache | WP Rocket |
| Images | Imagify |
| Security | Solid (iThemes) Security, Stop User Enumeration |
| Forms | Contact Form 7 (+ CF7 Polylang extension if multilingual) |
| Multilingual | Polylang Pro (+ Polylang for WooCommerce if shop) |
| Fields | ACF Pro |
| Media | SVG Support, WP Upload Restriction (max upload) |
| Backup/migration | Duplicator Pro |
| Slider | waiting for client recommendation – use Swiper in theme until then |

Do **not** add SearchWP or any other plugin unless requested. All mall sites share the same
plugin set, folder structure, coding style and CMS structure – copy the existing mall standard.

## CMS
- Every block/section, banner, CTA, menu, footer, SEO field and image is editable by the admin.
- Clients must never need HTML knowledge or a developer for content changes (modular sections, not hardcoded pages).
