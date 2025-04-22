[CmdletBinding()]
param ()

# $progressPreference = 'silentlyContinue'
# Write-Information "Downloading WinGet and its dependencies..."
# Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
# Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
# Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx -OutFile Microsoft.UI.Xaml.2.7.x64.appx
# Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
# Add-AppxPackage Microsoft.UI.Xaml.2.7.x64.appx
# Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

function Install-WinGet()
{
    $progressPreference = 'silentlyContinue'
    Write-Host "Installing WinGet PowerShell module from PSGallery..."
    Install-PackageProvider -Name NuGet -Force | Out-Null
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
    Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
    Repair-WinGetPackageManager
    Write-Host "Winget install completed."
}

function Invoke-Windows10Config()
{
    Write-Host "Configuring Windows 10..."
    winget configuration .\winget_vscode.yml
}

## End of functions ##############

try
{
    Install-WinGet -erroraction stop
}
catch
{
    Write-Host "Error installing WinGet: $_"
    Return
}

try
{
    Invoke-Windows10Config -erroraction stop
}
catch
{
    Write-Host "Error Configuring Windows 10: $_"
    Return
}