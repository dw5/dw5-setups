Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Turn off News and Interests https://www.reddit.com/r/sysadmin/comments/s1iomh/comment/hw0soe4/?utm_source=share&utm_medium=web2x&context=3

Write-Host "Turning off News and Interests..."

TASKKILL /IM explorer.exe /F

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Type DWord -Value 2

Start-Process explorer.exe