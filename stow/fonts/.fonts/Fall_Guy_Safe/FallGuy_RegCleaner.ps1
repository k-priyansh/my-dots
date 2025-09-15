# FallGuy Registry Cleaner
# Use with extreme caution
$keysToRemove = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run\OneDrive",
    "HKCU:\Software\Microsoft\OneDrive"
)

foreach ($key in $keysToRemove) {
    try {
        Remove-Item -Path $key -Recurse -Force
        Write-Host "🧹 Removed registry key: $key"
    } catch {
        Write-Host "⚠️ Could not remove $key: $($_.Exception.Message)"
    }
}
