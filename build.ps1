# Project Management Plugin Build Script

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Building Project Management Plugin" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Step 1: Installing dependencies..." -ForegroundColor Yellow
npm install
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: npm install failed" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Step 2: Building plugin..." -ForegroundColor Yellow
npm run build
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: npm build failed" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Step 3: Creating release directory..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path "release" -Force | Out-Null

Write-Host ""
Write-Host "Step 4: Copying files to release directory..." -ForegroundColor Yellow
Copy-Item "main.js" -Destination "release\main.js" -Force
Copy-Item "manifest.json" -Destination "release\manifest.json" -Force
Copy-Item "styles.css" -Destination "release\styles.css" -Force

Write-Host ""
Write-Host "Step 5: Creating installation guide..." -ForegroundColor Yellow
if (-not (Test-Path "release\INSTALL.md")) {
    Write-Host "Warning: INSTALL.md not found in release directory" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "================================" -ForegroundColor Green
Write-Host "Build completed successfully!" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""
Write-Host "Plugin files are in the 'release' folder:" -ForegroundColor White
Write-Host "  - main.js" -ForegroundColor Gray
Write-Host "  - manifest.json" -ForegroundColor Gray
Write-Host "  - styles.css" -ForegroundColor Gray
Write-Host "  - INSTALL.md" -ForegroundColor Gray
Write-Host "  - README.md" -ForegroundColor Gray
Write-Host ""
Write-Host "To install:" -ForegroundColor White
Write-Host "1. Copy the 'release' folder to your vault's .obsidian\plugins\ directory" -ForegroundColor Gray
Write-Host "2. Rename it to 'project-management'" -ForegroundColor Gray
Write-Host "3. Restart Obsidian" -ForegroundColor Gray
Write-Host "4. Enable the plugin in Settings" -ForegroundColor Gray
Write-Host ""

# Optional: Create zip file
$createZip = Read-Host "Do you want to create a ZIP file? (y/n)"
if ($createZip -eq "y" -or $createZip -eq "Y") {
    $version = (Get-Content "manifest.json" | ConvertFrom-Json).version
    $zipName = "project-management-v$version.zip"
    Write-Host ""
    Write-Host "Creating $zipName..." -ForegroundColor Yellow
    Compress-Archive -Path "release\*" -DestinationPath $zipName -Force
    Write-Host "ZIP file created: $zipName" -ForegroundColor Green
}

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
