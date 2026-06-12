$ErrorActionPreference = "Continue"
$missingRequired = @()

$miktexCandidates = @(
    "$env:LOCALAPPDATA\Programs\MiKTeX\miktex\bin\x64",
    "$env:ProgramFiles\MiKTeX\miktex\bin\x64",
    "$env:ProgramFiles(x86)\MiKTeX\miktex\bin\x64"
)

$perlCandidates = @(
    "C:\Strawberry\perl\bin",
    "C:\Strawberry\c\bin"
)

foreach ($candidate in ($miktexCandidates + $perlCandidates)) {
    if ((Test-Path $candidate) -and ($env:Path -notlike "*$candidate*")) {
        $env:Path = "$candidate;$env:Path"
    }
}

$commands = @(
    "xelatex",
    "latexmk",
    "biber",
    "kpsewhich",
    "perl"
)

Write-Host "LaTeX/toolchain commands"
foreach ($cmd in $commands) {
    $found = Get-Command $cmd -ErrorAction SilentlyContinue
    if ($found) {
        Write-Host ("[OK]      {0,-8} {1}" -f $cmd, $found.Source)
    } else {
        Write-Host ("[MISSING] {0}" -f $cmd)
        $missingRequired += $cmd
    }
}

Write-Host ""
Write-Host "Windows fonts"
$fontChecks = @(
    @{ Name = "Times New Roman"; Patterns = @("times.ttf", "timesbd.ttf", "timesi.ttf", "timesbi.ttf") },
    @{ Name = "Microsoft Sans Serif"; Patterns = @("micross.ttf") },
    @{ Name = "Courier New"; Patterns = @("cour.ttf", "courbd.ttf", "couri.ttf", "courbi.ttf") }
)

foreach ($font in $fontChecks) {
    $missing = @()
    foreach ($pattern in $font.Patterns) {
        $path = Join-Path $env:WINDIR "Fonts\$pattern"
        if (-not (Test-Path $path)) {
            $missing += $pattern
        }
    }
    if ($missing.Count -eq 0) {
        Write-Host ("[OK]      {0}" -f $font.Name)
    } else {
        Write-Host ("[MISSING] {0}: {1}" -f $font.Name, ($missing -join ", "))
        $missingRequired += $font.Name
    }
}

Write-Host ""
Write-Host "VS Code LaTeX extension"
$code = Get-Command "code" -ErrorAction SilentlyContinue
if ($code) {
    $extensions = & code --list-extensions
    if ($extensions -contains "James-Yu.latex-workshop") {
        Write-Host "[OK]      James-Yu.latex-workshop"
    } else {
        Write-Host "[MISSING] James-Yu.latex-workshop"
    }
} else {
    Write-Host "[SKIP]    VS Code CLI not found"
}

Write-Host ""
Write-Host "Recommended next commands if TeX is missing:"
Write-Host "  winget install --source winget --id MiKTeX.MiKTeX --exact"
Write-Host "  code --install-extension James-Yu.latex-workshop"

if ($missingRequired.Count -gt 0) {
    Write-Error ("Missing required LaTeX dependencies: {0}" -f ($missingRequired -join ", "))
    exit 1
}
