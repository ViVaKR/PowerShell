// 디펜더 완전삭제
# Dism /online /Disable-Feature /FeatureName:Windows-Defender /Remove /NoRestart /quiet

// Check the Windows Defender Configuration and Settings:	
# Get-MpPreference

// Turn off Windows Defender Real-Time Protection using PowerShell
# Set-MpPreference -DisableRealtimeMonitoring $true

// Turn onWindows Defender Real-Time Protection using PowerShell
# Set-MpPreference -DisableRealtimeMonitoring $true

// Add a File path exclusion:
#Set-MpPreference -ExclusionPath "C:\temp", "C:\VMs", "C:\NanoServer"

// Add process exclusion
# Set-MpPreference -ExclusionProcess "vmms.exe", "Vmwp.exe"
