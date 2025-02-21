<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Victor Floyd
    LinkedIn        : linkedin.com/in/VictorFloyd/
    GitHub          : github.com/Victor-Floyd
    Date Created    : 2025-02-21
    Last Modified   : 2025-02-21
    Version         : 1.0
    CVEs            : N/A
    Plugin ID      : 57608
    Vulnerability Description:[MEDIUM]: SMB Signing not required
    

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE

#>

# PowerShell Script to Enforce SMB Signing on Windows 10 Pro

# Ensure the script runs with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as Administrator!"
    exit
}

# Check Windows Version Compatibility
$osVersion = (Get-WmiObject Win32_OperatingSystem).Caption
if ($osVersion -notlike "*Windows 10 Pro*") {
    Write-Warning "This script is intended for Windows 10 Pro. Detected: $osVersion"
    exit
}

# Set the registry path for SMB server settings
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"

# Check if the registry path exists
if (-not (Test-Path $regPath)) {
    Write-Error "Registry path not found: $regPath"
    exit
}

try {
    # Enable 'Digitally sign communications (always)'
    Set-ItemProperty -Path $regPath -Name "RequireSecuritySignature" -Value 1 -ErrorAction Stop

    # Enable 'Digitally sign communications (if client agrees)'
    Set-ItemProperty -Path $regPath -Name "EnableSecuritySignature" -Value 1 -ErrorAction Stop

    # Confirm the changes
    $requireSign = Get-ItemProperty -Path $regPath -Name "RequireSecuritySignature"
    $enableSign = Get-ItemProperty -Path $regPath -Name "EnableSecuritySignature"

    Write-Output "RequireSecuritySignature is set to: $($requireSign.RequireSecuritySignature)"
    Write-Output "EnableSecuritySignature is set to: $($enableSign.EnableSecuritySignature)"

    # Restart the Server service to apply changes
    Restart-Service -Name "LanmanServer" -Force
    Write-Output "SMB signing has been enforced successfully. The Server service has been restarted."

} catch {
    Write-Error "An error occurred: $_"
}
