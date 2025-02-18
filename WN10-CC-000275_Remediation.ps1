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
    STIG-ID         : WN10-CC-000275

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE

#>

<#
.SYNOPSIS
    Disables drive redirection in Remote Desktop Sessions (WN10-CC-000275).

.DESCRIPTION
    This script updates the registry to enable the "Do not allow drive redirection" 
    policy, which sets the fDisableCdm value to 1 under:
    HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services

.PARAMETER EnableBlock
    Optional parameter to explicitly enable (1) or disable (0) the policy.
    Default is 1 (Enabled) to block drive redirection.

.EXAMPLE
    .\Set-RDPDriveRedirection.ps1
    Enables the policy by default (fDisableCdm = 1).

.EXAMPLE
    .\Set-RDPDriveRedirection.ps1 -EnableBlock 0
    Disables the policy (not STIG-compliant), allowing drive redirection.

.NOTES
    WN10-CC-000275: "Do not allow drive redirection" must be set to "Enabled".
#>

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("0","1")]
    [string]$EnableBlock = "1"
)

Write-Host "`nConfiguring 'Do not allow drive redirection' policy..."

# Define the registry path and value name
$regPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$valueName = "fDisableCdm"

# Create the path if it doesn't exist
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path does not exist. Creating: $regPath"
    New-Item -Path $regPath -Force | Out-Null
}

# Update the registry with the chosen setting
Set-ItemProperty -Path $regPath -Name $valueName -Value $EnableBlock -Type DWord

Write-Host "fDisableCdm set to $EnableBlock (1 = drive redirection blocked, 0 = allowed)."
Write-Host "Policy configuration complete."
