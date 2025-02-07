<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Victor Floyd
    LinkedIn        : linkedin.com/in/VictorFloyd/
    GitHub          : github.com/Victor-Floyd
    Date Created    : 2025-02-06
    Last Modified   : 2025-02-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE

#>

# Ensure the script is running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltinRole]::Administrator))
{
    Write-Error "This script must be run as Administrator. Exiting."
    exit 1
}

Write-Output "Configuring Windows Event Log Size Policy..."

# Define the registry path for the policy setting
$regPath = "HKLM:\Software\Policies\Microsoft\Windows\EventLog\Application"

# Create the registry key if it does not exist
if (-not (Test-Path $regPath)) {
    Write-Output "Creating registry path: $regPath"
    New-Item -Path $regPath -Force | Out-Null
}

# Set the Maximum Log Size to 32768 KB (or greater)
$logSizeKB = 32768
Write-Output "Setting Maximum Log Size to $logSizeKB KB..."
Set-ItemProperty -Path $regPath -Name "MaxSize" -Value $logSizeKB -Type DWord

# Force Group Policy update
Write-Output "Applying Group Policy changes..."
gpupdate /force

Write-Output "STIG configuration applied successfully."
