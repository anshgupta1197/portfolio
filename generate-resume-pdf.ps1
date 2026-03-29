# generate-resume-pdf.ps1
# Renders resume-print.html via browser engine and saves a pixel-perfect PDF.
# No Word, no conversion artefacts - output looks exactly like the browser page.

$htmlPath = "C:\Anshika_Portfolio\assets\resume\resume-print.html"
$pdfPath  = "C:\Users\anshgupta\Desktop\Anshika_resume_01.pdf"

# Find Microsoft Edge or Google Chrome
$candidates = @(
  "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
  "C:\Program Files\Microsoft\Edge\Application\msedge.exe",
  "C:\Program Files\Google\Chrome\Application\chrome.exe",
  "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
)

$browser = $null
foreach ($p in $candidates) {
  if (Test-Path $p) { $browser = $p; break }
}

if (-not $browser) {
  Write-Error "Neither Microsoft Edge nor Google Chrome was found. Install one and re-run this script."
  exit 1
}

$fileUri = "file:///" + $htmlPath.Replace("\", "/")

# Temp profile so Edge allows local file access without security blocks
$tmpProfile = Join-Path $env:TEMP "edge-resume-pdf-profile"

Write-Host "Browser  : $browser"
Write-Host "Source   : $htmlPath"
Write-Host "Output   : $pdfPath"
Write-Host ""
Write-Host "Generating PDF..." -ForegroundColor Cyan

# Remove stale output so we can detect success
if (Test-Path $pdfPath) { Remove-Item $pdfPath -Force -ErrorAction SilentlyContinue }

& $browser `
  --headless=new `
  --disable-gpu `
  --no-sandbox `
  --disable-web-security `
  --allow-file-access-from-files `
  "--user-data-dir=$tmpProfile" `
  --no-pdf-header-footer `
  "--print-to-pdf=$pdfPath" `
  "--virtual-time-budget=8000" `
  $fileUri 2>$null

# Wait briefly for file to be flushed
Start-Sleep -Seconds 2

if (Test-Path $pdfPath) {
  $size = (Get-Item $pdfPath).Length
  Write-Host ""
  Write-Host "Done! PDF saved to: $pdfPath ($([math]::Round($size/1KB, 1)) KB)" -ForegroundColor Green
} else {
  Write-Error "PDF file was not created. Check that Edge/Chrome can access local files."
  exit 1
}
