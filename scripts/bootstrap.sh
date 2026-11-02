#!/usr/bin/env bash
# bootstrap.sh — Initialize any project with the recursos_ia ecosystem
# Usage: bash /path/to/recursos_ia/scripts/bootstrap.sh [project_path] [library_path]

set -e

PROJECT="${1:-.}"
LIB="${2:-/mnt/d/recursos_ia}"
PROJECT="$(realpath "$PROJECT")"

echo ""
echo "[Bootstrap] Initializing project at: $PROJECT"

# ── 1. Detect active harness ─────────────────────────────────────────────────
DETECTED="Generic"
[ -n "$ANTIGRAVITY" ]                          && DETECTED="Antigravity"
[ -f "$PROJECT/CLAUDE.md" ]                    && DETECTED="Claude Code"
[ -d "$PROJECT/.cursor" ]                      && DETECTED="Cursor"
[ -d "$PROJECT/.opencode" ]                    && DETECTED="OpenCode"
[ -d "$PROJECT/.windsurf/rules" ]              && DETECTED="Windsurf"
[ -f "$PROJECT/.github/copilot-instructions.md" ] && DETECTED="VS Code Copilot"
[ -f "$PROJECT/GEMINI.md" ]                    && DETECTED="Gemini CLI"
command -v codex &>/dev/null                   && DETECTED="Codex CLI"
[ -d "$PROJECT/.kiro" ]                        && DETECTED="Kiro IDE"

echo ""
echo "[Harness] Auto-detected: $DETECTED"
echo "Available Harnesses:"
echo "  1. Antigravity"
echo "  2. Claude Code"
echo "  3. Cursor"
echo "  4. OpenCode"
echo "  5. Windsurf"
echo "  6. VS Code Copilot"
echo "  7. Gemini CLI"
echo "  8. Codex CLI"
echo "  9. Kiro IDE"
echo " 10. Generic"
echo ""
read -p "Enter number to select harness, or press Enter to keep [$DETECTED]: " choice

HARNESS="$DETECTED"
case "$choice" in
    1) HARNESS="Antigravity" ;;
    2) HARNESS="Claude Code" ;;
    3) HARNESS="Cursor" ;;
    4) HARNESS="OpenCode" ;;
    5) HARNESS="Windsurf" ;;
    6) HARNESS="VS Code Copilot" ;;
    7) HARNESS="Gemini CLI" ;;
    8) HARNESS="Codex CLI" ;;
    9) HARNESS="Kiro IDE" ;;
    10) HARNESS="Generic" ;;
esac

echo ""
echo "[Harness] Proceeding with: $HARNESS"

# ── 2. Copy base files ───────────────────────────────────────────────────────
sync_file() {
    local f=$1
    local auto_update=$2
    local src="$LIB/$f"
    local dst="$PROJECT/$f"
    
    if [ ! -f "$dst" ]; then
        cp "$src" "$dst"
        echo "  [copy] $f"
    else
        if ! cmp -s "$src" "$dst"; then
            if [ "$auto_update" = "true" ]; then
                cp "$src" "$dst"
                echo "  [update] $f (overwritten)"
            else
                read -p "  [?] $f has changed. Overwrite with library version? (y/N) " ans
                if [ "$ans" = "y" ] || [ "$ans" = "Y" ]; then
                    cp "$src" "$dst"
                    echo "  [update] $f (overwritten)"
                else
                    echo "  [skip] $f (kept local version)"
                fi
            fi
        else
            echo "  [skip] $f (up to date)"
        fi
    fi
}

for f in SOUL.md HARNESS.md PROMPT_CRAFT.md; do sync_file "$f" "true"; done
for f in AGENTS.md RULES.md; do sync_file "$f" "false"; done

# ── 3. Harness-specific setup ────────────────────────────────────────────────
case "$HARNESS" in
    "Claude Code")
        [ ! -f "$PROJECT/CLAUDE.md" ] && ln -s "$PROJECT/AGENTS.md" "$PROJECT/CLAUDE.md" && echo "  [link] CLAUDE.md → AGENTS.md"
        ;;
    "Gemini CLI")
        [ ! -f "$PROJECT/GEMINI.md" ] && ln -s "$PROJECT/AGENTS.md" "$PROJECT/GEMINI.md" && echo "  [link] GEMINI.md → AGENTS.md"
        ;;
    "Windsurf")
        mkdir -p "$PROJECT/.windsurf/rules"
        cp "$PROJECT/AGENTS.md" "$PROJECT/.windsurf/rules/AGENTS.md"
        echo "  [copy] AGENTS.md → .windsurf/rules/"
        ;;
    "VS Code Copilot")
        mkdir -p "$PROJECT/.github"
        cp "$PROJECT/AGENTS.md" "$PROJECT/.github/copilot-instructions.md"
        echo "  [copy] AGENTS.md → .github/copilot-instructions.md"
        ;;
    "Cursor")
        mkdir -p "$PROJECT/.cursor/rules"
        cp "$PROJECT/AGENTS.md" "$PROJECT/.cursor/rules/AGENTS.md"
        echo "  [copy] AGENTS.md → .cursor/rules/"
        ;;
esac

# ── 4. Create project CONTEXT.md ─────────────────────────────────────────────
if [ ! -f "$PROJECT/CONTEXT.md" ]; then
    cp "$LIB/templates/CONTEXT.md" "$PROJECT/CONTEXT.md"
    echo "  [create] CONTEXT.md (from template)"
else
    echo "  [skip] CONTEXT.md (already exists)"
fi

# ── 5. Create Knowledge Repository ───────────────────────────────────────────
if [ ! -d "$PROJECT/docs/kr" ]; then
    mkdir -p "$PROJECT/docs/kr"
    printf "# Knowledge Repository\n\n| Archivo | Tipo | Descripción |\n|---|---|---|\n" > "$PROJECT/docs/kr/README.md"
    echo "  [create] docs/kr/ + README.md"
else
    echo "  [skip] docs/kr/ (already exists)"
fi

# ── 6. Create doc_errores.md ─────────────────────────────────────────────────
if [ ! -f "$PROJECT/doc_errores.md" ]; then
    cp "$LIB/templates/ERROR_LOG.md" "$PROJECT/doc_errores.md"
    echo "  [create] doc_errores.md (from template)"
else
    echo "  [skip] doc_errores.md (already exists)"
fi

# ── 7. Copy skills ───────────────────────────────────────────────────────────
if [ ! -d "$PROJECT/skills" ]; then
    cp -r "$LIB/skills" "$PROJECT/skills"
    echo "  [copy] skills/"
else
    cp -r "$LIB/skills/"* "$PROJECT/skills/"
    echo "  [update] skills/ (synced)"
fi

# ── Summary ──────────────────────────────────────────────────────────────────
echo ""
echo "[Bootstrap] Done!"
echo ""
echo "  Harness : $HARNESS"
echo "  Project : $PROJECT"
echo ""
echo "  Skills available:"
echo "    /sdd          Spec-Driven Development (5 phases)"
echo "    /craft        Convert vague prompt to robust prompt"
echo "    /grill-me     Interview before complex work"
echo "    /code-review  Review diff before PR"
echo "    /tdd          Red-green-refactor"
echo "    /diagnose     Disciplined debugging"
echo "    /fix-known    Check doc_errores.md first"
echo "    /kr-query     Query Knowledge Repository"
echo "    /kr-write     Write to Knowledge Repository"
echo "    /engram       Persist session state"
echo "    /handoff      Pass context between sessions"
echo "    /ponytail     YAGNI-first mode"
echo "    /doc-sweep    Sync docs after work"
echo ""
echo "  Next: Edit CONTEXT.md with your project domain + module map"
echo "  Docs: $LIB/docs/GUIDE_quickstart.md"
echo ""
