Param(
    [string]$BuildDir = '.',
    [string]$Output = 'reactos-msvc14-arm-WinPE.zip'
)

$Staging = Join-Path $BuildDir 'winpe-hybrid'
$ReactDir = Join-Path $Staging 'react'
$DllDir = Join-Path $ReactDir 'dlls'

Remove-Item $Staging -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $DllDir -Force | Out-Null

# Basic applications to include
$apps = @(
    'base\applications\cmd\cmd.exe',
    'base\applications\explorer\explorer.exe',
    'base\applications\taskmgr\taskmgr.exe'
)

foreach ($app in $apps) {
    $src = Join-Path $BuildDir $app
    if (Test-Path $src) {
        Copy-Item $src $ReactDir -Force
    }
}

# Optional: copy DLLs if present
$systemDir = Join-Path $BuildDir 'dll'
if (Test-Path $systemDir) {
    Get-ChildItem $systemDir -Filter '*.dll' | ForEach-Object {
        Copy-Item $_.FullName $DllDir -Force
    }
}

# Create autorun script
$autorun = @"
@echo off
if exist react\explorer.exe (
  start "" react\explorer.exe
) else (
  react\cmd.exe
)
"@
$autorunPath = Join-Path $Staging 'autorun.cmd'
Set-Content -Path $autorunPath -Value $autorun -Encoding ASCII

# Create template winpeshl.ini
$winpeshl = '[LaunchApps]\nreact\\explorer.exe'
Set-Content -Path (Join-Path $Staging 'winpeshl.ini') -Value $winpeshl -Encoding ASCII

# Compress archive
if (Test-Path $Output) { Remove-Item $Output -Force }
Compress-Archive -Path $Staging\* -DestinationPath $Output
Write-Host "Created $Output"
