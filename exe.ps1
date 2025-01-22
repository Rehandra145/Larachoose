# ProjectLauncher v1.0.0

function Show-Banner { 
   Write-Host @"

  ____            _           _      ____ _                                
 |  _ \ _ __ ___ (_) ___  ___| |_   / ___| |__   ___   ___  ___  ___ _ __ 
 | |_) | '__/ _ \| |/ _ \/ __| __| | |   | '_ \ / _ \ / _ \/ __|/ _ \ '__|
 |  __/| | | (_) | |  __/ (__| |_  | |___| | | | (_) | (_) \__ \  __/ |   
 |_|   |_|  \___// |\___|\___|\__|  \____|_| |_|\___/ \___/|___/\___|_|   
               |__/                                          by handera    
"@ -ForegroundColor Cyan
   Write-Host "Laravel/Node.js Project Tool" -ForegroundColor Cyan
   Write-Host "---------------------------" -ForegroundColor Cyan
}

# Main execution
Clear-Host
Show-Banner

# Initialize workspace
Set-Location -Path "C:\laragon\www"
Write-Host "Working Directory: $(Get-Location)" -ForegroundColor Green

# List projects
$projects = Get-ChildItem -Directory
Write-Host "`nAvailable Projects:" -ForegroundColor Cyan
$i = 1
foreach ($project in $projects) {
   Write-Host "$i. $($project.Name)"
   $i++
}
Write-Host ""

# Project selection
$project_num = Read-Host "Select project number (1-$($projects.Count))"

# Validate selection
if (-not ($project_num -match "^\d+$") -or [int]$project_num -lt 1 -or [int]$project_num -gt $projects.Count) {
   Write-Host "ERROR: Invalid project number!" -ForegroundColor Red
   Exit 1
}

$project_name = ($projects[$project_num - 1]).Name
Set-Location -Path "C:\laragon\www\$project_name"
Write-Host "Selected: $project_name" -ForegroundColor Green

# Server options
$server = Read-Host "Launch development server? (Y/n)"

if ($server -eq "" -or $server.ToLower() -eq "y") {
   Write-Host "`nServer Options:" -ForegroundColor Cyan
   Write-Host "1. PHP Artisan Server (Laravel)"
   Write-Host "2. NPM Development Server (Node.js)"
   Write-Host ""
   
   $choice = Read-Host "Select server type (1-2)"

   switch ($choice) {
       "1" {
           Write-Host "Starting Laravel server..." -ForegroundColor Yellow
           Start-Process "php" "artisan serve" -NoNewWindow
           Start-Sleep -Seconds 3
           Start-Process "chrome.exe" "http://127.0.0.1:8000/"
       }
       "2" {
           Write-Host "Starting Node.js server..." -ForegroundColor Yellow
           Start-Process "npm" "run dev" -NoNewWindow
       }
       default {
           Write-Host "ERROR: Invalid choice!" -ForegroundColor Red
           Exit 1
       }
   }
}

# Launch VS Code
Write-Host "Opening VS Code..." -ForegroundColor Yellow
code .
Write-Host "Done! Happy coding!" -ForegroundColor Green