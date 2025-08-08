[CmdletBinding()]
param (
    [string]$ConfigFile = "winget_vscode.yml",
    [switch]$SkipPrerequisites,
    [switch]$Force
)

# Set error action preference
$ErrorActionPreference = 'Stop'

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
    param (
        [string]$ConfigPath
    )

    Write-Host "Configuring Windows 10 using configuration file: $ConfigPath..."
    winget configuration $ConfigPath
}

## End of functions ##############

# Main execution block
try
{
    Write-Log "Starting Windows 10 setup script..."
    
    if (-not $SkipPrerequisites)
    {
        $configPath = Test-Prerequisites
    }
    else
    {
        $configPath = Join-Path $PSScriptRoot $ConfigFile
    }
    
    Install-WinGet
    Invoke-Windows10Config -ConfigPath $configPath
    
    Write-Log "Setup completed successfully!" 
    Write-Log "Please restart your computer to ensure all changes take effect."
}
catch
{
    Write-Log "Setup failed: $($_.Exception.Message)" -Level Error
    Write-Log "Stack trace: $($_.ScriptStackTrace)" -Level Error
    exit 1
}