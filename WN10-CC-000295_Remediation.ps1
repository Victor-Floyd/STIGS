<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Victor Floyd
    LinkedIn        : linkedin.com/in/VictorFloyd/
    GitHub          : github.com/Victor-Floyd
    Date Created    : 2025-02-18
    Last Modified   : 2025-02-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000295

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE

#>

<#
.SYNOPSIS
    Configures the RSS Feeds policy to prevent downloading of enclosures.

.DESCRIPTION
    This script sets the registry key:
    HKLM:\Software\Policies\Microsoft\Internet Explorer\Feeds
    DisableEnclosureDownload (DWORD) = 1
    
    to enforce "Prevent downloading of enclosures" = Enabled.
#>

Write-Host "Configuring 'Prevent downloading of enclosures' policy for RSS Feeds..."

# Define the registry path
$regPath = "HKLM:\Software\Policies\Microsoft\Internet Explorer\Feeds"

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    Write-Host "Creating registry path: $regPath"
    New-Item -Path "HKLM:\Software\Policies\Microsoft\Internet Explorer" -Name "Feeds" -Force | Out-Null
}

# Set or update the policy value
Write-Host "Setting 'DisableEnclosureDownload' to 1..."
New-ItemProperty -Path $regPath `
                 -Name "DisableEnclosureDownload" `
                 -PropertyType DWord `
                 -Value 1 `
                 -Force | Out-Null

Write-Host "Policy has been updated successfully. Please reboot or run gpupdate /force for changes to take effect."

<#
You may need to reboot or run gpupdate /force for the policy to apply immediately.
#>