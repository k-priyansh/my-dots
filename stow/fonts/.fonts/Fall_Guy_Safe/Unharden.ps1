# FallGuy SafeNet Unhardener
# Re-enables services and removes firewall blocks
# Author: Thomas Couch

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Please run this script as Administrator."
    Exit
}

$servicesToEnable = @(
    "DiagTrack",
    "WMPNetworkSvc"
)

foreach ($svc in $servicesToEnable) {
    try {
        Set-Service -Name $svc -StartupType Manual
        Start-Service -Name $svc -ErrorAction SilentlyContinue
        Write-Host "✅ Re-enabled service: $svc"
    } catch {
        Write-Host "⚠️ Could not re-enable $svc: $($_.Exception.Message)"
    }
}

$firewallRules = @(
    "Block C:\Program Files\Windows Media Player\wmpnetwk.exe",
    "Block C:\Program Files\Windows Defender Advanced Threat Protection\MsSense.exe",
    "Block C:\WINDOWS\System32\OneDriveSetup.exe"
)

foreach ($rule in $firewallRules) {
    try {
        Remove-NetFirewallRule -DisplayName $rule
        Write-Host "✅ Removed firewall rule: $rule"
    } catch {
        Write-Host "⚠️ Could not remove rule $rule: $($_.Exception.Message)"
    }
}

Write-Host "`n🔓 FallGuy SafeNet Unhardener complete." -ForegroundColor Yellow
