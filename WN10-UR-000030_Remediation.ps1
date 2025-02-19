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
    STIG-ID         : WN10-UR-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE

#>

<#
.SYNOPSIS
    Configures the "Back up files and directories" user right to only allow Administrators.

.DESCRIPTION
    This script updates the Local Security Policy to ensure that only the Administrators group
    is assigned the "Back up files and directories" (SeBackupPrivilege) right.

.NOTES
    This change requires a system reboot or "secedit /refreshpolicy machine_policy" to take effect.
#>

Write-Host "Configuring 'Back up files and directories' user right..."

# Define the user right and the correct group
$seceditExport = "C:\Windows\Temp\secpol.cfg"
$seceditBackup = "C:\Windows\Temp\secpol_backup.cfg"

# Backup existing security settings
Write-Host "Backing up current security policy..."
secedit /export /cfg $seceditBackup /areas USER_RIGHTS

# Modify the policy file
(Get-Content $seceditBackup) -replace "SeBackupPrivilege.*", "SeBackupPrivilege = Administrators" | Set-Content $seceditExport

# Apply the new settings
Write-Host "Applying updated security policy..."
secedit /configure /db c:\windows\security\local.sdb /cfg $seceditExport /areas USER_RIGHTS /quiet

# Clean up temporary files
Remove-Item $seceditExport -Force
Remove-Item $seceditBackup -Force

Write-Host "Policy updated successfully. Reboot or run 'gpupdate /force' for changes to take effect."
