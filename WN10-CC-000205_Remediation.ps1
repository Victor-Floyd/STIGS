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
    STIG-ID         : WN10-CC-000205

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE

#>


<#
.SYNOPSIS
    Configures Windows Telemetry to an acceptable level (Basic = 1 by default).
    Complies with WN10-CC-000205 by disallowing Full telemetry.

.DESCRIPTION
    This script creates/updates the registry key that corresponds to the 
    "Allow Telemetry" Group Policy setting under:
    Computer Configuration >>
    Administrative Templates >>
    Windows Components >>
    Data Collection and Preview Builds >>
    "Allow Telemetry".

.PARAMETER TelemetryLevel
    0 = Security (Enterprise/Education only)
    1 = Basic
    2 = Enhanced
    3 = Full (Not allowed per STIG)

.EXAMPLE
    .\Set-Telemetry.ps1 -TelemetryLevel 1
    Sets telemetry to Basic.

.NOTES
    If you're on Windows 10 Pro and do not have the Enterprise/Education SKU, 
    '0 - Security' is not supported. Use 1 (Basic) or 2 (Enhanced).
#>

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("0","1","2","3")]
    [string]$TelemetryLevel = "1"
)

Write-Host "`nConfiguring Telemetry level to '$TelemetryLevel'..."

# Define the registry path and value name
$regPath = "HKLM:\Software\Policies\Microsoft\Windows\DataCollection"
$valueName = "AllowTelemetry"

# Create the path if it doesn't exist
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path does not exist. Creating path: $regPath"
    New-Item -Path $regPath -Force | Out-Null
}

# Set the Telemetry level
Set-ItemProperty -Path $regPath -Name $valueName -Value $TelemetryLevel -Type DWord

Write-Host "Telemetry level has been set to '$TelemetryLevel'."

# Optional: If you must also limit Enhanced diagnostic data (V-220833),
# you can include additional registry changes here if required by your policy.
#
# For example (placeholder):
# $limitEnhancedRegName = "LimitEnhancedDiagnosticDataWindowsAnalytics"
# Set-ItemProperty -Path $regPath -Name $limitEnhancedRegName -Value 1 -Type DWord
# Write-Host "Enhanced diagnostic data has been limited per V-220833."
