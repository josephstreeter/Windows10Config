# Windows 10 Configuration

The purpose is to create an automated process to configure a fresh Windows host for development work. Additionally, keep the installed software update date.

## Concept

Currently there are two paths. The first path is to use Winget and the PowerShell Winget module to install all of the applications and add-ons. The second path is to use Winget and a configuration template to install and configure the host in an idempotent way, similar to Desired State Configuration.