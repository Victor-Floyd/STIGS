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
    STIG-ID         : WN10-AU-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE

#>

<#
.SYNOPSIS
    Enables auditing for User Account Management failures on a Windows 10 system.

.DESCRIPTION
    This script configures the Advanced Audit Policy setting:
        Computer Configuration >>
        Windows Settings >>
        Security Settings >>
        Advanced Audit Policy Configuration >>
        System Audit Policies >>
        Account Management >>
        "Audit User Account Management"
    to record "Failure" events.
#>

Write-Host "Checking current 'Audit User Account Management' settings..."

# Capture the current audit settings for User Account Management
$auditSetting = auditpol /get /subcategory:"User Account Management" 2>&1

if ($auditSetting -match "Failure          Enabled") {
    Write-Host "'Audit User Account Management' for failures is already enabled."
} else {
    Write-Host "Enabling 'Audit User Account Management' for failures..."
    auditpol /set /subcategory:"User Account Management" /failure:enable
    Write-Host "Policy updated successfully."
}
