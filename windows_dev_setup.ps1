function install-WinGet()
{
    [CmdletBinding()]
    [OutputType([void])]
    Param()
    <#
        .SYNOPSIS
            Installs the WinGet PowerShell module from PSGallery and bootstraps WinGet.
        .DESCRIPTION
            This function installs the WinGet PowerShell module from the PowerShell Gallery (PSGallery) and uses the Repair-WinGetPackageManager cmdlet to bootstrap WinGet.
        .EXAMPLE
            install-WinGet
        .NOTES
            This function requires administrative privileges to install the WinGet PowerShell module and bootstrap WinGet.
            Ensure you have an active internet connection to download the necessary packages from PSGallery.
            This function will suppress output from the Install-PackageProvider and Install-Module cmdlets to keep the console clean, but you can remove the Out-Null to see the output if needed.
    #>
    $progressPreference = "silentlyContinue" # Suppress progress bar for cleaner output

    try
    {
        Write-Output "Installing WinGet PowerShell module from PSGallery..."
        
        Write-Output "Installing Nuget provider..."
        if (Get-PackageProvider -Name Nuget -ErrorAction SilentlyContinue)
        {
            Write-Output "NuGet provider already installed."
        }
        else
        {
            Write-Output "NuGet provider not found. Installing..."
            Install-PackageProvider -Name NuGet -Force -ErrorAction Stop | Out-Null
        }
        
        Write-Output "Installing WinGet module..."
        
        if (Get-Module -Name Microsoft.WinGet.Client -ListAvailable)
        {
            Write-Output "WinGet PowerShell module already installed."
        }
        else
        {
            Write-Output "WinGet PowerShell module not found. Installing..."
            Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery -ErrorAction Stop | Out-Null
        }
        
        Write-Output "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
        Repair-WinGetPackageManager -ErrorAction Stop
        Write-Output "Done."
    }
    catch
    {
        Write-Error "Failed to install WinGet PowerShell module from PSGallery. Error: $_"
    }
}

function Install-PowerShell7()
{
    [CmdletBinding()]
    [OutputType([void])]
    Param()
    
    <#
        .SYNOPSIS
            Installs PowerShell 7 using WinGet.
        .DESCRIPTION
            This function installs PowerShell 7, the latest version of PowerShell, using the WinGet package manager. It accepts package agreements to ensure a smooth installation process.
        .EXAMPLE
            Install-PowerShell7
        .NOTES
            This function requires that WinGet is already installed and available in the system PATH.
            Ensure you have administrative privileges to install PowerShell 7 using WinGet.
            This function will suppress output from the winget install command to keep the console clean, but you can remove the Out-Null to see the output if needed.
            If PowerShell 7 is already installed, WinGet will skip the installation and report that the package is already installed.
#>
    try
    {
        if (Get-Command pwsh -ErrorAction SilentlyContinue)
        {
            Write-Output "PowerShell 7 is already installed."
            return
        }
        # Check if WinGet is available
        if (-NOT (Get-Command winget -ErrorAction SilentlyContinue))
        {
            Write-Error "WinGet is not available. Please install WinGet first."
            return
        }

        Write-Output "Installing PowerShell 7 using WinGet..."
        winget install Microsoft.PowerShell -e -h --accept-source-agreements --accept-package-agreements
    }
    catch
    {
        Write-Error "Failed to install PowerShell 7 using WinGet. Error: $_"
    }
}

function Install-WindowsTerminal()
{
    [CmdletBinding()]
    [OutputType([void])]
    Param()

    try
    {
        if (Get-Command wt -ErrorAction SilentlyContinue)
        {
            Write-Output "Windows Terminal is already installed."
            return
        }

        if (-NOT (Get-Command winget -ErrorAction SilentlyContinue))
        {
            Write-Error "WinGet is not available. Please install WinGet first."
            return
        }
        
        Write-Output "Installing Windows Terminal using WinGet..."
        winget install Microsoft.WindowsTerminal -e -h --accept-package-agreements --accept-source-agreements
    }
    catch
    {
        Write-Error "Failed to install Windows Terminal using WinGet. Error: $_"
    }
}

function Install-Git
{
    [CmdletBinding()]
    [OutputType([void])]
    Param()

    <#
        .SYNOPSIS
            Installs Git and GitHub CLI using WinGet.
        .DESCRIPTION
            This function installs Git, a version control system, and the GitHub CLI, a command-line tool for managing GitHub repositories, using the WinGet package manager. It accepts package agreements to ensure a smooth installation process.
        .EXAMPLE
            Install-Git
        .NOTES
            This function requires that WinGet is already installed and available in the system PATH.
            Ensure you have administrative privileges to install Git and GitHub CLI using WinGet.
            This function will suppress output from the winget install commands to keep the console clean, but you can remove the Out-Null to see the output if needed.
            If Git or GitHub CLI is already installed, WinGet will skip the installation and report that the package is already installed.
            If you encounter any issues with the installation, you can troubleshoot by running the winget install command manually in the terminal to see the error message.
    #>

    if (Get-Command git -ErrorAction SilentlyContinue)
    {
        Write-Output "Git is already installed."
        return
    }
    if (Get-Command gh -ErrorAction SilentlyContinue)
    {
        Write-Output "GitHub CLI is already installed."
        return
    }

    if (-NOT (Get-Command winget -ErrorAction SilentlyContinue))
    {
        Write-Error "WinGet is not available. Please install WinGet first."
        return
    }
    Write-Output "Installing Git and GitHub CLI using WinGet..."
    winget install Git.Git -e -h --accept-package-agreements
    winget install GitHub.cli -e -h --accept-package-agreements
}

Function Install-AzureTools()
{
    [CmdletBinding()]
    [OutputType([void])]
    Param()
    <#
        .SYNOPSIS
            Installs various Azure tools using WinGet.
        .DESCRIPTION
            This function installs a set of Azure-related tools using the WinGet package manager. These tools include Azure Storage Explorer, Azure Functions Core Tools, Azure Data Studio, Bicep, and Azure CLI.
        .EXAMPLE
            Install-AzureTools
        .NOTES
            This function requires that WinGet is already installed and available in the system PATH.
            Ensure you have administrative privileges to install these tools using WinGet.
            This function will suppress output from the winget install commands to keep the console clean, but you can remove the Out-Null to see the output if needed.
            The function will also install optional tools that are commented out. You can uncomment them if you need those specific tools.
            This function will not check for the existence of each tool before attempting to install it, so it may attempt to install a tool that is already installed.
            If a tool is already installed, WinGet will skip the installation and report that the package is already installed.
    #>
    $progressPreference = 'stop'

    winget install Microsoft.Azure.StorageExplorer
    # winget install Microsoft.Azure.StorageEmulator
    winget install Microsoft.Azure.FunctionsCoreTools
    winget install Microsoft.Azure.DataStudio
    # winget install Microsoft.Azure.CosmosEmulator
    # winget install  Microsoft.Azure.IoTExplorer
    winget install Microsoft.Bicep
    winget install Microsoft.AzureCLI
    # winget install Microsoft.ServiceFabricRuntime

    Install-Module Az -Scope CurrentUser -Repository PSGallery -Force -ErrorAction SilentlyContinue | Out-Null
}

function Install-AzCopy()
{
    [CmdletBinding()]
    [OutputType([void])]
    Param()
    <#
        .SYNOPSIS
            Installs AzCopy using WinGet or PowerShell script.
        .DESCRIPTION
            This function installs AzCopy, a command-line tool for copying data to and from Azure storage, using WinGet or a PowerShell script if WinGet is not available.
        .EXAMPLE
            Install-AzCopy
        .NOTES
            This function requires that WinGet is already installed and available in the system PATH.
            If WinGet is not available, it will use a PowerShell script to download and install AzCopy.
            Ensure you have administrative privileges to install AzCopy using WinGet or the PowerShell script.
            This function will suppress output from the winget install command to keep the console clean, but you can remove the Out-Null to see the output if needed.
            The function will check if WinGet is available and will use it to install AzCopy. If WinGet is not available, it will fall back to using a PowerShell script to download and install AzCopy.
            If AzCopy is already installed, WinGet will skip the installation and report that the package is already installed.
            If you encounter any issues with the installation, you can troubleshoot by running the winget install command manually in the terminal to see the error message.
            The function will also add the AzCopy executable to the user's PATH environment variable for easy access from the command line.
        .LINK
            https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10
    #>

    $progressPreference = 'stop'
    # winget to install:
    winget install Microsoft.Azure.AZCopy.10 -e -h --accept-package-agreements

    # PowerShell Script to install
    Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile AzCopy.zip -UseBasicParsing
    Expand-Archive ./AzCopy.zip ./AzCopy -Force
    mkdir "$home/AzCopy"
    Get-ChildItem ./AzCopy/*/azcopy.exe | Move-Item -Destination "$home\AzCopy\AzCopy.exe"
    $userenv = [System.Environment]::GetEnvironmentVariable("Path", "User")
    [System.Environment]::SetEnvironmentVariable("PATH", $userenv + ";$home\AzCopy", "User")
}

function Install-Git
{
    [CmdletBinding()]
    [OutputType([void])]
    Param()

    winget install Git.Git -e -h --accept-package-agreements
    winget install GitHub.cli -e -h --accept-package-agreements
}

function Install-VisualStudioCode()
{
    [CmdletBinding()]
    [OutputType([void])]
    Param()

    <#
        .SYNOPSIS
            Installs Visual Studio Code using WinGet.
        .DESCRIPTION
            This function installs Visual Studio Code, a popular code editor, using the WinGet package manager. It accepts package agreements to ensure a smooth installation process.
        .EXAMPLE
            Install-VisualStudioCode
        .NOTES
            This function requires that WinGet is already installed and available in the system PATH.
            Ensure you have administrative privileges to install Visual Studio Code using WinGet.
            This function will suppress output from the winget install command to keep the console clean, but you can remove the Out-Null to see the output if needed.
            If Visual Studio Code is already installed, WinGet will skip the installation and report that the package is already installed.
            If you encounter any issues with the installation, you can troubleshoot by running the winget install command manually in the terminal to see the error message.

            This function uses the -e (exact) and -h (silent) flags to ensure a non-interactive installation, which is useful for automated scripts or setups.
    
    #>

    winget install Microsoft.VisualStudioCode -e -h --accept-package-agreements
}

function Install-VSCodeExtensions()
{
    [CmdletBinding()]
    [OutputType([void])]
    Param()

    <#
        .SYNOPSIS
            Installs a set of Visual Studio Code extensions using the code command.
        .DESCRIPTION
            This function installs a predefined list of Visual Studio Code extensions using the code command. These extensions are commonly used for development in various languages and platforms.
        .EXAMPLE
            Install-VSCodeExtensions
        .NOTES
            This function requires that Visual Studio Code is already installed and available in the system PATH.
            Ensure you have administrative privileges to install these extensions using the code command.
            This function will suppress output from the code --install-extension commands to keep the console clean, but you can remove the Out-Null to see the output if needed.
            The function will attempt to install each extension listed, and if an extension is already installed, the code command will skip the installation and report that the extension is already installed.
            If you encounter any issues with the installation of a specific extension, you can troubleshoot by running the code command manually in the terminal to see the error message.
            You can also customize the list of extensions by adding or removing extensions from the list below based on your development needs.
    #>
    
    # Check if Visual Studio Code is installed
    
    Write-Output "Installing Visual Studio Code extensions..."

    $DefaultExtensions = "ms-vscode.powershell"
    "ms-vsliveshare.vsliveshare"
    "ms-vsonline.vsonline"
    "ms-dotnettools.vscode-dotnet-runtime"
    
    Foreach ($Extension in $DefaultExtensions)
    {
        code --install-extension $Extension --force
    }

    $RemoteExtensions = "ms-vscode-remote.remote-containers",
    "ms-vscode-remote.remote-ssh",
    "ms-vscode-remote.remote-ssh-edit",
    "ms-vscode-remote.remote-wsl",
    "ms-vscode-remote.vscode-remote-extensionpack"
    
    Foreach ($Extension in $RemoteExtensions)
    {
        code --install-extension $Extension --force
    }

    $AzureExtensions = "AzurePolicy.azurepolicyextension",
    "ms-azuretools.vscode-azureresourcegroups",
    "ms-azuretools.vscode-azurestorage",
    "ms-azuretools.vscode-azurevirtualmachines",
    "ms-azuretools.vscode-bicep",
    "ms-azuretools.vscode-azureappservice",
    "ms-azuretools.vscode-azuredatastudio",
    "ms-azuretools.vscode-azurefunctions",
    "ms-azuretools.vscode-docker",
    "ms-vscode.azure-account",
    "ms-vscode.azurecli",
    "ms-vscode.vscode-node-azure-pack",
    "msazurermtools.azurerm-vscode-tools"
    
    Foreach ($Extension in $AzureExtensions)
    {
        code --install-extension $Extension --force
    }
}

# Main script execution starts here
# Check if running as Administrator (required for some installations)
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "This script requires administrative privileges. Please run as Administrator."
    exit
}

try
{
    install-WinGet -ErrorAction Stop
    Write-Output "WinGet installation completed successfully."
}
catch
{
    Write-Error "An error occurred during WinGet installation: $_"
    exit
}

try
{
    winget config set winget.settings.acceptSourceAgreements true
    Write-Output "Accepted source agreements for WinGet."
    winget config set winget.settings.acceptPackageAgreements true
    Write-Output "Accepted package agreements for WinGet."
    winget config set winget.settings.autoUpdate true
    Write-Output "Enabled auto-update for WinGet."
}
catch
{
    Write-Error "An error occurred while configuring WinGet settings: $_"
}

# try
# {
#     Install-PowerShell7 -ErrorAction Stop
#     Write-Output "PowerShell 7 installation completed successfully."
# }
# catch
# {
#     Write-Error "An error occurred during PowerShell 7 installation: $_"
# }

# try
# {
#     Install-WindowsTerminal
#     Write-Output "Windows Terminal installation completed successfully."
# }
# catch
# {
#     Write-Error "An error occurred during Windows Terminal installation: $_"
# }

# try
# {
#     Install-Git
#     Write-Output "Git and GitHub CLI installation completed successfully."
# }
# catch
# {
#     Write-Error "An error occurred during Git and GitHub CLI installation: $_"
# }