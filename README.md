# Windows 10/11 Development Configuration

An automated solution for configuring fresh Windows hosts for development work using WinGet Configuration files and PowerShell automation. This project provides reliable, repeatable, and idempotent machine setup for development environments.

## 🎯 Purpose

- **Automate development environment setup** - Zero-touch configuration of Windows development machines
- **Maintain consistency** - Ensure all team members have identical development environments
- **Stay current** - Keep installed software up-to-date through automated processes
- **Save time** - Reduce manual setup from hours to minutes

## 🏗️ Project Structure

```text
Windows10Config/
├── README.md                    # This file - project documentation
├── PowerShell/
│   └── windows_dev_setup.ps1   # PowerShell automation script
├── Sandbox/
│   └── sandbox.wsb             # Windows Sandbox configuration
└── Winget/
    ├── Win10_Setup.ps1         # Main setup script with error handling
    ├── winget_vscode.yml       # Original configuration file
    └── winget_enhanced.yml     # Enhanced configuration with additional tools
```

## 🚀 Quick Start

### Prerequisites

- Windows 10 (version 1903+) or Windows 11
- Administrator privileges
- Internet connection

### Option 1: Enhanced Setup (Recommended)

```powershell
# Run as Administrator
cd Winget
.\Win10_Setup.ps1 -ConfigFile "winget_enhanced.yml"
```

### Option 2: Basic Setup

```powershell
# Run as Administrator  
cd Winget
.\Win10_Setup.ps1
```

## 📦 What Gets Installed

### Core Development Tools

- **Git** - Version control system
- **PowerShell 7** - Modern PowerShell experience
- **Windows Terminal** - Modern command-line interface
- **Visual Studio Code** - Primary code editor
- **.NET 8 SDK** - .NET development framework
- **Node.js** - JavaScript runtime for web development

### Azure Development Stack

- **Azure CLI** - Command-line tools for Azure
- **Azure Storage Explorer** - GUI for Azure Storage
- **Azure Data Studio** - Database management for Azure
- **Bicep** - Infrastructure as Code for Azure
- **Azure PowerShell (Az module)** - Azure management from PowerShell

### Productivity & DevOps Tools

- **Docker Desktop** - Containerization platform
- **Postman** - API development and testing
- **Oh My Posh** - PowerShell prompt customization
- **SQL Server Management Studio** - Database management

### Visual Studio Code Extensions

- **PowerShell Extension** - PowerShell development support
- **Azure Extension Pack** - Complete Azure development toolkit
- **GitLens** - Enhanced Git capabilities
- **GitHub Copilot** - AI-powered coding assistant
- **YAML Extension** - YAML file support
- **REST Client** - API testing within VS Code
- **Live Share** - Real-time collaborative editing

### PowerShell Modules

- **Az** - Azure PowerShell module
- **Microsoft.Graph** - Microsoft Graph API access
- **ExchangeOnlineManagement** - Exchange Online management
- **PSReadLine** - Enhanced command-line editing
- **PSScriptAnalyzer** - PowerShell script analysis
- **VSTeam** - Azure DevOps integration

## 🔧 Configuration Files

### `winget_vscode.yml` (Original)

- Basic development setup
- Core tools and VS Code extensions
- Suitable for minimal installations

### `winget_enhanced.yml` (Recommended)

- Comprehensive development environment
- Additional productivity tools
- Enhanced VS Code extensions
- Complete Azure development stack
- Better organization and documentation

## 💡 Key Features

### ✅ Reliability Improvements

- **Enhanced error handling** - Comprehensive logging and error recovery
- **Prerequisites validation** - Checks system requirements before installation
- **Dependency management** - Proper installation order and dependency resolution
- **Idempotent execution** - Safe to run multiple times

### ✅ Modern Development Workflow

- **Container support** - Docker Desktop for containerized development
- **API development** - Postman and REST Client for API testing
- **Version control** - Git with GitLens for enhanced Git capabilities
- **Cloud-native** - Complete Azure development toolkit

### ✅ Developer Experience

- **Windows Terminal** - Modern command-line experience with tabs and themes
- **Oh My Posh** - Beautiful, informative PowerShell prompts
- **GitHub Copilot** - AI-powered code completion and suggestions
- **Developer Mode** - Enables Windows developer features

## 🛠️ Advanced Usage

### Custom Configuration

Create your own configuration file based on the enhanced template:

```powershell
# Copy and modify the enhanced configuration
cp winget_enhanced.yml my_custom_config.yml
# Edit my_custom_config.yml as needed
.\Win10_Setup.ps1 -ConfigFile "my_custom_config.yml"
```

### Environment-Specific Setups

- **Minimal setup**: Use `winget_vscode.yml` for basic development
- **Full stack**: Use `winget_enhanced.yml` for comprehensive setup
- **Azure-focused**: Uncomment Azure Functions tools in enhanced config
- **Enterprise**: Add Visual Studio Community 2022 for large projects

### Script Parameters

```powershell
.\Win10_Setup.ps1 [[-ConfigFile] <string>] [-SkipPrerequisites] [-Force]

# Examples:
.\Win10_Setup.ps1 -ConfigFile "winget_enhanced.yml"
.\Win10_Setup.ps1 -SkipPrerequisites
.\Win10_Setup.ps1 -Force
```

## 🧪 Testing

### Windows Sandbox

Use the provided Windows Sandbox configuration for safe testing:

```powershell
# Open Windows Sandbox with the configuration
.\Sandbox\sandbox.wsb
```

### Validation

The setup script includes built-in validation:

- System requirements check
- Administrator privileges verification
- Configuration file validation
- Post-installation verification

## 🔍 Troubleshooting

### Common Issues

1. **WinGet not found**: The script automatically installs WinGet PowerShell module
2. **Permission denied**: Ensure running as Administrator
3. **Network issues**: Check internet connectivity for package downloads
4. **Installation failures**: Check the detailed logs for specific error messages

### Logging

The enhanced setup script provides comprehensive logging:

- **Info**: Normal operation status
- **Warning**: Non-critical issues
- **Error**: Critical failures with stack traces

## 🚦 What's Next

After successful installation:

1. **Restart your computer** - Some installations require a restart
2. **Configure Git** - Set up your Git identity
3. **Sign in to services** - Azure CLI, GitHub, etc.
4. **Customize VS Code** - Install additional extensions as needed
5. **Set up development projects** - Clone repositories and start coding

## 📚 References

- [Microsoft Learn: WinGet Configuration](https://learn.microsoft.com/en-us/windows/package-manager/configuration/)
- [WinGet CLI GitHub Repository](https://github.com/microsoft/winget-cli)
- [WinGet DSC PowerShell Module](https://www.powershellgallery.com/packages/Microsoft.WinGet.DSC)
- [Azure Developer Tools](https://azure.microsoft.com/en-us/downloads/)

## 🤝 Contributing

Feel free to submit issues and enhancement requests. When contributing:

1. Test configurations in Windows Sandbox
2. Update documentation for any changes
3. Follow PowerShell best practices
4. Ensure idempotent behavior

---

**Note**: This project supports both Windows 10 and Windows 11. Some features may require specific Windows versions or updates.
