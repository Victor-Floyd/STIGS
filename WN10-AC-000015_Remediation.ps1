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
    STIG-ID         : WN10-AC-000015

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE

#>

<#
.SYNOPSIS
    Sets the "Reset account lockout counter after" to 15 minutes on a local machine.

.DESCRIPTION
    Uses 'net accounts' to configure the local Account Lockout Policy for Windows 10:
      - /lockoutwindow:15 => Resets the bad password counter after 15 minutes

    Make sure you also have a non-zero lockout threshold (e.g., net accounts /lockoutthreshold:3).

.EXAMPLE
    .\Set-AccountLockoutWindow.ps1
    Sets "Reset account lockout counter after" to 15 minutes.

.NOTES
    WN10-AC-000015 requires the period to be 15 minutes.
#>

Write-Host "Configuring 'Reset account lockout counter after' to 15 minutes..."
net accounts /lockoutwindow:15

Write-Host "Done. Please verify your Account Lockout Threshold is non-zero."



<#
If you get:

System error 87 has occurred.
The parameter is incorrect.

Run the following:
Write-Host "Configuring account lockout policy..."
net accounts /lockoutthreshold:3 /lockoutwindow:15 /lockoutduration:30
Write-Host "Policy configuration complete."


#>