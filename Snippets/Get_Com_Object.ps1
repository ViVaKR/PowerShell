﻿Get-ChildItem HKLM:\Software\Classes -ea 0| Where-Object {$_.PSChildName -match '^\w+\.\w+$' -and (Get-ItemProperty "$($_.PSPath)\CLSID" -ea 0)} | Format-Table PSChildName


Get-WMIObject Win32_ClassicCOMClassSetting
