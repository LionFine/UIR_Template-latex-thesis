$ErrorActionPreference = "Stop"

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

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$thesisDir = Join-Path $root "thesis"

if (-not (Get-Command latexmk -ErrorAction SilentlyContinue)) {
    Write-Error "latexmk is not available. Install MiKTeX or TeX Live, then reopen the terminal."
}

Push-Location $thesisDir
try {
    latexmk -xelatex main.tex
} finally {
    Pop-Location
}
