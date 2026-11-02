#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Bootstrap any project with the recursos_ia ecosystem in < 2 minutes.
.PARAMETER ProjectPath
    Path to the project directory. Defaults to current directory.
.PARAMETER LibraryPath
    Path to recursos_ia library. Defaults to d:\recursos_ia.
.EXAMPLE
    pwsh -File d:\recursos_ia\scripts\bootstrap.ps1 -ProjectPath C:\my-project
#>

param(
    [string]$ProjectPath = ".",
    [string]$LibraryPath = "d:\recursos_ia"
)

$ErrorActionPreference = "Stop"
$Project = Resolve-Path $ProjectPath
$Lib = Resolve-Path $LibraryPath

Write-Host "`n[Bootstrap] Initializing project at: $Project" -ForegroundColor Cyan

# ── 1. Detect active harness ────────────────────────────────────────────────
$detectedHarness = "Generic"
if ($env:ANTIGRAVITY)                                  { $detectedHarness = "Antigravity" }
elseif (Test-Path "$Project\CLAUDE.md")                { $detectedHarness = "Claude Code" }
elseif (Test-Path "$Project\.cursor")                  { $detectedHarness = "Cursor" }
elseif (Test-Path "$Project\.opencode")                { $detectedHarness = "OpenCode" }
elseif (Test-Path "$Project\.windsurf\rules")          { $detectedHarness = "Windsurf" }
elseif (Test-Path "$Project\.github\copilot-instructions.md") { $detectedHarness = "VS Code Copilot" }
elseif (Test-Path "$Project\GEMINI.md")                { $detectedHarness = "Gemini CLI" }
elseif (Get-Command codex -ErrorAction SilentlyContinue) { $detectedHarness = "Codex CLI" }
elseif (Test-Path "$Project\.kiro")                    { $detectedHarness = "Kiro IDE" }

Write-Host "`n[Harness] Auto-detected: $detectedHarness" -ForegroundColor Yellow
Write-Host "Available Harnesses:"
Write-Host "  1. Antigravity"
Write-Host "  2. Claude Code"
Write-Host "  3. Cursor"
Write-Host "  4. OpenCode"
Write-Host "  5. Windsurf"
Write-Host "  6. VS Code Copilot"
Write-Host "  7. Gemini CLI"
Write-Host "  8. Codex CLI"
Write-Host "  9. Kiro IDE"
Write-Host " 10. Generic"
Write-Host ""
$choice = Read-Host "Enter number to select harness, or press Enter to keep [$detectedHarness]"

$harness = $detectedHarness
switch ($choice) {
    "1"  { $harness = "Antigravity" }
    "2"  { $harness = "Claude Code" }
    "3"  { $harness = "Cursor" }
    "4"  { $harness = "OpenCode" }
    "5"  { $harness = "Windsurf" }
    "6"  { $harness = "VS Code Copilot" }
    "7"  { $harness = "Gemini CLI" }
    "8"  { $harness = "Codex CLI" }
    "9"  { $harness = "Kiro IDE" }
    "10" { $harness = "Generic" }
}

Write-Host "`n[Harness] Proceeding with: $harness" -ForegroundColor Green

# ── 2. Copy base files ───────────────────────────────────────────────────────
$autoUpdateFiles = @("SOUL.md", "HARNESS.md", "PROMPT_CRAFT.md")
$promptUpdateFiles = @("AGENTS.md", "RULES.md")

function Sync-File {
    param($f, $autoUpdate)
    $src = "$Lib\$f"
    $dst = "$Project\$f"
    if (-not (Test-Path $dst)) {
        Copy-Item $src $dst
        Write-Host "  [copy] $f" -ForegroundColor Gray
    } else {
        $srcHash = (Get-FileHash $src).Hash
        $dstHash = (Get-FileHash $dst).Hash
        if ($srcHash -ne $dstHash) {
            if ($autoUpdate) {
                Copy-Item $src $dst -Force
                Write-Host "  [update] $f (overwritten)" -ForegroundColor Yellow
            } else {
                $ans = Read-Host "  [?] $f has changed. Overwrite with library version? (y/N)"
                if ($ans -eq 'y' -or $ans -eq 'Y') {
                    Copy-Item $src $dst -Force
                    Write-Host "  [update] $f (overwritten)" -ForegroundColor Yellow
                } else {
                    Write-Host "  [skip] $f (kept local version)" -ForegroundColor DarkGray
                }
            }
        } else {
            Write-Host "  [skip] $f (up to date)" -ForegroundColor DarkGray
        }
    }
}

foreach ($f in $autoUpdateFiles) { Sync-File $f $true }
foreach ($f in $promptUpdateFiles) { Sync-File $f $false }

# ── 3. Harness-specific symlinks ─────────────────────────────────────────────
switch ($harness) {
    "Claude Code" {
        if (-not (Test-Path "$Project\CLAUDE.md")) {
            New-Item -ItemType SymbolicLink -Path "$Project\CLAUDE.md" -Target "$Project\AGENTS.md" | Out-Null
            Write-Host "  [link] CLAUDE.md → AGENTS.md" -ForegroundColor Gray
        }
    }
    "Gemini CLI" {
        if (-not (Test-Path "$Project\GEMINI.md")) {
            New-Item -ItemType SymbolicLink -Path "$Project\GEMINI.md" -Target "$Project\AGENTS.md" | Out-Null
            Write-Host "  [link] GEMINI.md → AGENTS.md" -ForegroundColor Gray
        }
    }
    "Windsurf" {
        $dir = "$Project\.windsurf\rules"
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
        Copy-Item "$Project\AGENTS.md" "$dir\AGENTS.md" -Force
        Write-Host "  [copy] AGENTS.md → .windsurf/rules/" -ForegroundColor Gray
    }
    "VS Code Copilot" {
        $dir = "$Project\.github"
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
        Copy-Item "$Project\AGENTS.md" "$dir\copilot-instructions.md" -Force
        Write-Host "  [copy] AGENTS.md → .github/copilot-instructions.md" -ForegroundColor Gray
    }
    "Cursor" {
        $dir = "$Project\.cursor\rules"
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
        Copy-Item "$Project\AGENTS.md" "$dir\AGENTS.md" -Force
        Write-Host "  [copy] AGENTS.md → .cursor/rules/" -ForegroundColor Gray
    }
}

# ── 4. Create project CONTEXT.md ─────────────────────────────────────────────
$contextDst = "$Project\CONTEXT.md"
if (-not (Test-Path $contextDst)) {
    Copy-Item "$Lib\templates\CONTEXT.md" $contextDst
    Write-Host "  [create] CONTEXT.md (from template)" -ForegroundColor Gray
} else {
    Write-Host "  [skip] CONTEXT.md (already exists)" -ForegroundColor DarkGray
}

# ── 5. Create Knowledge Repository ───────────────────────────────────────────
$krDir = "$Project\docs\kr"
if (-not (Test-Path $krDir)) {
    New-Item -ItemType Directory -Path $krDir -Force | Out-Null
    $krReadme = "# Knowledge Repository`n`n| Archivo | Tipo | Descripción |`n|---|---|---|`n"
    Set-Content "$krDir\README.md" $krReadme -Encoding UTF8
    Write-Host "  [create] docs/kr/ + README.md" -ForegroundColor Gray
} else {
    Write-Host "  [skip] docs/kr/ (already exists)" -ForegroundColor DarkGray
}

# ── 6. Create doc_errores.md ─────────────────────────────────────────────────
$errorsDst = "$Project\doc_errores.md"
if (-not (Test-Path $errorsDst)) {
    Copy-Item "$Lib\templates\ERROR_LOG.md" $errorsDst
    Write-Host "  [create] doc_errores.md (from template)" -ForegroundColor Gray
} else {
    Write-Host "  [skip] doc_errores.md (already exists)" -ForegroundColor DarkGray
}

# ── 7. Copy skills ───────────────────────────────────────────────────────────
$skillsDst = "$Project\skills"
if (-not (Test-Path $skillsDst)) {
    Copy-Item "$Lib\skills" $skillsDst -Recurse
    Write-Host "  [copy] skills/" -ForegroundColor Gray
} else {
    Copy-Item "$Lib\skills\*" $skillsDst -Recurse -Force
    Write-Host "  [update] skills/ (synced)" -ForegroundColor Yellow
}

# ── Summary ──────────────────────────────────────────────────────────────────
Write-Host "`n[Bootstrap] Done!" -ForegroundColor Green
Write-Host ""
Write-Host "  Harness : $harness"
Write-Host "  Project : $Project"
Write-Host ""
Write-Host "  Skills available:"
Write-Host "    /sdd          Spec-Driven Development (5 phases)"
Write-Host "    /craft        Convert vague prompt to robust prompt"
Write-Host "    /grill-me     Interview before complex work"
Write-Host "    /code-review  Review diff before PR"
Write-Host "    /tdd          Red-green-refactor"
Write-Host "    /diagnose     Disciplined debugging"
Write-Host "    /fix-known    Check doc_errores.md first"
Write-Host "    /kr-query     Query Knowledge Repository"
Write-Host "    /kr-write     Write to Knowledge Repository"
Write-Host "    /engram       Persist session state"
Write-Host "    /handoff      Pass context between sessions"
Write-Host "    /ponytail     YAGNI-first mode"
Write-Host "    /doc-sweep    Sync docs after work"
Write-Host ""
Write-Host "  Next: Edit CONTEXT.md with your project domain + module map"
Write-Host "  Docs: $Lib\docs\GUIDE_quickstart.md"
Write-Host ""
