@echo off
REM Project Management Plugin Build Script

echo ================================
echo Building Project Management Plugin
echo ================================

echo.
echo Step 1: Installing dependencies...
call npm install

echo.
echo Step 2: Building plugin...
call npm run build

echo.
echo Step 3: Creating release directory...
if not exist "release" mkdir release

echo.
echo Step 4: Copying files to release directory...
copy /Y main.js release\main.js
copy /Y manifest.json release\manifest.json
copy /Y styles.css release\styles.css

echo.
echo ================================
echo Build completed successfully!
echo ================================
echo.
echo Plugin files are in the 'release' folder:
echo   - main.js
echo   - manifest.json
echo   - styles.css
echo.
echo To install:
echo 1. Copy the 'release' folder to your vault's .obsidian\plugins\ directory
echo 2. Rename it to 'project-management'
echo 3. Restart Obsidian
echo 4. Enable the plugin in Settings
echo.
pause
