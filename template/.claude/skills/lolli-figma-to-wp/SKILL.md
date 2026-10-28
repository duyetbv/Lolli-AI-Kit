---
name: lolli-figma-to-wp
description: Implement a Figma design (page or section) into a Lolli WordPress theme pixel-accurately while keeping everything CMS-editable. Use when given a Figma link/frame or design export to build in WordPress.
---

# Figma → Lolli WordPress

1. **Read the design**: Figma MCP (`get_design_context`, `get_screenshot`, `get_variable_defs`) or exports in
   `Project-Infomations/Design/`. Collect desktop 1440 **and** mobile 393 frames + programming notes.
2. **Map tokens**: colours/fonts/spacing → existing `:root` tokens in `main.css`. Add a token only if truly new.
3. **Split into sections**: each horizontal band = one section layout. Reuse existing sections/components first;
   list new ones and design their ACF fields (use the `lolli-acf-architect` agent for complex pages).
4. **Build** each new section with the `lolli-new-section` skill. Figma code output is a *reference*, not final code:
   rewrite with BEM, tokens, WP helpers, escaping, no absolute positioning hacks, no inline styles.
5. **Assets**: export images at 2x for image-size planning only – real content images come from the media library.
   Icons → `inc/icons.php`. Fonts → self-hosted.
6. **Content**: enter design content through the CMS (or seeder), never in templates.
7. **Compare**: screenshot local page at 1440 and 393 and compare to Figma (spacing, font size/line-height, colours,
   hover/active states). Fix diffs; note anything not comparable (missing frames) in the Jira ticket.
