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
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE

#>

# Define the registry path for Lock Screen Camera settings
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Ensure the registry key exists
if (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the policy to disable camera access from the lock screen
Set-ItemProperty -Path $RegPath -Name "NoLockScreenCamera" -Value 1 -Type DWord

# Confirm the change
$Result = Get-ItemProperty -Path $RegPath -Name "NoLockScreenCamera"

if ($Result.NoLockScreenCamera -eq 1) {
    Write-Host "Camera access from the lock screen has been disabled successfully."
} else {
    Write-Host "Failed to disable camera access from the lock screen."
}

# Restart the system for changes to take effect (optional)
# Restart-Computer -Force

