#!/usr/bin/env bash
# Lolli AI Kit – install/update the shared AI coding standard into a Lolli WordPress project.
# Usage:
#   ./setup.sh --root "/path/to/app/public" --project "Project Name" --prefix twp \
#              [--theme twp] [--jira TWP] [--url http://twp.local] [--force]
# Re-run any time to update rules/skills/agents to the latest kit version.
# Theme/plugin CLAUDE.md files are created only if missing (they hold project notes) unless --force.
set -euo pipefail

KIT_DIR="$(cd "$(dirname "$0")" && pwd)"
TPL="$KIT_DIR/template"
ROOT="."; PROJECT=""; PREFIX=""; THEME=""; JIRA=""; URL=""; FORCE=0

while [ $# -gt 0 ]; do
  case "$1" in
    --root) ROOT="$2"; shift 2;;
    --project) PROJECT="$2"; shift 2;;
    --prefix) PREFIX="$2"; shift 2;;
    --theme) THEME="$2"; shift 2;;
    --jira) JIRA="$2"; shift 2;;
    --url) URL="$2"; shift 2;;
    --force) FORCE=1; shift;;
    -h|--help) sed -n '2,8p' "$0"; exit 0;;
    *) echo "Unknown option: $1" >&2; exit 1;;
  esac
done

[ -n "$PROJECT" ] && [ -n "$PREFIX" ] || { echo "Required: --project and --prefix (see --help)" >&2; exit 1; }
[ -d "$ROOT/wp-content" ] || { echo "No wp-content in $ROOT – point --root at the WordPress docroot" >&2; exit 1; }

prefix="$(echo "$PREFIX" | tr '[:upper:]-' '[:lower:]_')"          # snake: twp, my_mall
slug="$(echo "$prefix" | tr '_' '-')"                               # kebab: twp, my-mall
PREFIXU="$(echo "$prefix" | tr '[:lower:]' '[:upper:]')"            # TWP, MY_MALL
THEME="${THEME:-$slug}"
JIRA="${JIRA:-$(echo "$slug" | tr -d '-' | tr '[:lower:]' '[:upper:]')}"
URL="${URL:-http://$slug.local}"
VERSION="$(cat "$KIT_DIR/VERSION")"

# Custom plugins = wp-content/plugins/<slug>-*
PLUGINS=()
for d in "$ROOT"/wp-content/plugins/"$slug"-*/; do [ -d "$d" ] && PLUGINS+=("$(basename "$d")"); done
PLUGINFILES=""; TEXTDOMAINS=""
for p in "${PLUGINS[@]+"${PLUGINS[@]}"}"; do
  PLUGINFILES+="<file>wp-content/plugins/$p</file>"$'\n\t'
  TEXTDOMAINS+="<element value=\"$p\"/>"$'\n\t\t\t\t'
done

render() { # $1 = file to rewrite (content overwritten, inode kept), $2 = plugin name (optional)
  local tmp; tmp="$(mktemp)"
  KIT_PROJECT="$PROJECT" KIT_prefix="$prefix" KIT_PREFIX="$PREFIXU" KIT_slug="$slug" KIT_theme="$THEME" \
  KIT_JIRA="$JIRA" KIT_URL="$URL" KIT_PLUGIN="${2:-}" KIT_PF="$PLUGINFILES" KIT_TD="$TEXTDOMAINS" \
  perl -pe '
    s/\{\{PROJECT\}\}/$ENV{KIT_PROJECT}/g; s/\{\{prefix\}\}/$ENV{KIT_prefix}/g; s/\{\{PREFIX\}\}/$ENV{KIT_PREFIX}/g;
    s/\{\{slug\}\}/$ENV{KIT_slug}/g; s/\{\{theme\}\}/$ENV{KIT_theme}/g; s/\{\{JIRA\}\}/$ENV{KIT_JIRA}/g;
    s/\{\{URL\}\}/$ENV{KIT_URL}/g; s/\{\{PLUGIN\}\}/$ENV{KIT_PLUGIN}/g;
    s/\{\{PLUGINFILES\}\}/$ENV{KIT_PF}/g; s/\{\{TEXTDOMAINS\}\}/$ENV{KIT_TD}/g;' "$1" > "$tmp"
  cat "$tmp" > "$1"; rm -f "$tmp"
}

echo "Lolli AI Kit v$VERSION → $ROOT  (project=$PROJECT prefix=$prefix slug=$slug theme=$THEME jira=$JIRA)"

# 1. Shared standard (always updated)
( cd "$TPL" && find . -type f ! -path './_*' ! -name '.DS_Store' ! -name '.fuse_hidden*' ) | while read -r f; do
  mkdir -p "$ROOT/$(dirname "$f")"
  cat "$TPL/$f" > "$ROOT/$f"
  render "$ROOT/$f"
  echo "  ✓ ${f#./}"
done
echo "$VERSION" > "$ROOT/.claude/lolli-ai-kit-version"

# 2. Theme CLAUDE.md (project notes – keep unless --force)
TDIR="$ROOT/wp-content/themes/$THEME"
if [ -d "$TDIR" ]; then
  if [ ! -f "$TDIR/CLAUDE.md" ] || [ $FORCE -eq 1 ]; then
    cat "$TPL/_theme/CLAUDE.md" > "$TDIR/CLAUDE.md"; render "$TDIR/CLAUDE.md"; echo "  ✓ themes/$THEME/CLAUDE.md"
  else echo "  • themes/$THEME/CLAUDE.md exists – kept (use --force to replace)"; fi
else echo "  ! theme folder $THEME not found – skipped theme CLAUDE.md"; fi

# 3. Plugin CLAUDE.md
for p in "${PLUGINS[@]+"${PLUGINS[@]}"}"; do
  PF="$ROOT/wp-content/plugins/$p/CLAUDE.md"
  if [ ! -f "$PF" ] || [ $FORCE -eq 1 ]; then
    cat "$TPL/_plugin/CLAUDE.md" > "$PF"; render "$PF" "$p"; echo "  ✓ plugins/$p/CLAUDE.md"
  else echo "  • plugins/$p/CLAUDE.md exists – kept"; fi
done

if grep -rIl '{{[A-Za-z]*}}' "$ROOT/AGENTS.md" "$ROOT/CLAUDE.md" "$ROOT/.claude" "$ROOT/phpcs.xml.dist" >/dev/null 2>&1; then
  echo "WARNING: unreplaced placeholders:"; grep -rIn '{{[A-Za-z]*}}' "$ROOT/AGENTS.md" "$ROOT/CLAUDE.md" "$ROOT/.claude" "$ROOT/phpcs.xml.dist"
fi
echo "Done. Fill in the 'Project notes' section of the theme/plugin CLAUDE.md files."
