<# 
	Get-Alias
	New-Alias
	Set-Alias
	Remove-Alias
	Export-Alias
	Import-Alias
#>

#- ? -> Where-Object                                             
#- % -> ForEach-Object                                           
#! ac -> Add-Content, Get, Set, Clear
Get-Process -Name pwsh | Out-String  | Set-Content -Path ".\Results\set-content.txt"
Get-Process -Name pwsh | Out-File -Append ".\Results\out-file.txt"

#! cat -> Get-Content
Write-Output "Out-String | Set-Content"
Get-Content -Path ".\Results\set-content.txt"

Write-Output "Out-File"
Get-Content -Path ".\Results\out-file.txt"

#! chdir -> Set-Location, cd, sl  
                               
#- clc -> Clear-Content            

#- clear -> Clear-Host,cls

#- clhy -> Clear-History        

#- cli -> Clear-Item
#- clp -> Clear-ItemProperty                                     
#- clv -> Clear-Variable                                         
#- cnsn -> Connect-PSSession                                     
#- compare -> Compare-Object

#! copy -> Copy-Item, cp, cpi

#- cpp -> Copy-ItemProperty
#- cvpa -> Convert-Path

#- dbp -> Disable-PSBreakpoint

#- Decode-SqlName                                     22.1.1     SqlServer
#! del -> Remove-Item
Get-ChildItem "E:\Temp\Hello" -Include *.csv -Recurse | Remove-Item
Remove-Item HKLM:\Software\MyCompany\OldApp -Recurse


#- diff -> Compare-Object

#! dir -> Get-ChildItem
#! ls -> Get-ChildItem
#! gci -> Get-ChildItem
#* `l` (link)
#* `d` (directory)
#* `a` (archive)
#* `r` (read-only)
#* `h` (hidden)
#* `s` (system)

#- dnsn -> Disconnect-PSSession                                  
#- ebp -> Enable-PSBreakpoint                                    
#- echo -> Write-Output                                          
#- Encode-SqlName                                     22.1.1     SqlServer
#- epal -> Export-Alias                                          
#- epcsv -> Export-Csv                                           
#- erase -> Remove-Item                                          
#- etsn -> Enter-PSSession                                       
#- exsn -> Exit-PSSession                                        
#- fc -> Format-Custom                                           
#- fhx -> Format-Hex                                  7.0.0.0    Microsoft.ty
#- fl -> Format-List                                             
#- foreach -> ForEach-Object                                     
#- ft -> Format-Table                                            
#- fw -> Format-Wide                                             
#- gal -> Get-Alias                                              
#- gas -> Get-AuthenticodeSignature                              
#- gbp -> Get-PSBreakpoint                                       
#- gc -> Get-Content                                             
#- gcb -> Get-Clipboard                               7.0.0.0    Microsoft.eme…
                                        
#- gcm -> Get-Command                                            
#- gcs -> Get-PSCallStack                                        
#- gdr -> Get-PSDrive                                            
#- gerr -> Get-Error                                             
#- ghy -> Get-History                                            
#- gi -> Get-Item                                                
#- gin -> Get-ComputerInfo                            7.0.0.0    Microsoft.eme…
#- gjb -> Get-Job                                                
#- gl -> Get-Location                                            
#- gm -> Get-Member                                              
#- gmo -> Get-Module                                             
#- gp -> Get-ItemProperty                                        
#- gps -> Get-Process                                            
#- gpv -> Get-ItemPropertyValue                                  
#- group -> Group-Object                                         
#- gsn -> Get-PSSession                                          
#! gsv -> Get-Service
Set-Service -Name sshd -StartupType Automatic
Set-Service -Name ssh-agent -StartupType Automatic
Start-Service ssh-agent
Get-Service ssh-agent

#! gtz -> Get-TimeZone

#! gu -> Get-Unique
1,1,1,1,12,23,4,5,4643,5,3,3,3,3,3,3,3 | Sort-Object | Get-Unique
Get-Process | Sort-Object | Select-Object ProcessName | Get-Unique -AsString

#! gv -> Get-Variable

#! h -> Get-History, history
Get-History | Where-Object {$_.CommandLine -like "*Get*"}
                                 
#! icm -> Invoke-Command

#! iex -> Invoke-Expression
$Command = "Get-Process"
Invoke-Expression $Command
".\Demo-InvokeCommand.ps1" | Invoke-Expression

#! ihy -> Invoke-History
Get-History
Invoke-History 2

#! ii -> Invoke-Item
Invoke-Item .\ProcessLog.csv

#! ipal -> Import-Alias
Import-Alias test.txt
Get-Alias | Select-Object Name, Options
Get-Alias -Definition Get-Process
Get-Alias -Name gpv, gpv, ls

#! ipcsv -> Import-Csv
$csv = Import-Csv -Path .\tblDirector.csv
$csv | Get-Member

#! ipmo -> Import-Module
Get-Module -ListAvailable | Import-Module
Import-Module -Name PSDiagnostics
$Env:PSModulePath

$m = Get-Module -ListAvailable PSDiagnostics, Dism
Import-Module -ModuleInfo $m
Get-Module -List | Format-Table -Property Name, ModuleType -AutoSize
Get-Module -ListAvailable PowerShellGet | Select-Object Path

#! irm -> Invoke-RestMethod
# RSS 피드 가져오기
Invoke-RestMethod -Uri https://blogs.msdn.microsoft.com/powershell/feed/ | Format-Table -Property Title, pubDate

#! iwr -> Invoke-WebRequest
Invoke-RestMethod -Uri https://blogs.msdn.microsoft.com/powershell/feed/ | Format-Table -Property Title, pubDate

$Response.InputFields | Where-Object { $_.name -like "* Value*" } | Select-Object Name, Value

#! kill -> Stop-Process                                          
Stop-Process -Name "notepad"

#! man -> help

#! md -> mkdir
New-Item -ItemType Directory -Path p3\1\2\3 -Force
mkdir -p p3\3\1\2\3

#! measure -> Measure-Object
Get-ChildItem | Measure-Object
Get-ChildItem | Measure-Object -Property length -Minimum -Maximum
get-content .\set-contents.txt | Measure-Object -Character -Line -Word

#- mi -> Move-Item                                               
#- mount -> New-PSDrive                                          
#- move -> Move-Item                                             
#- mp -> Move-ItemProperty                                       
#- mv -> Move-Item                                               
#- nal -> New-Alias                                              
#- ndr -> New-PSDrive                                            
#- ni -> New-Item                                                
#- nmo -> New-Module                                             
#- nsn -> New-PSSession                                          

#- nv -> New-Variable

#! ogv -> Out-GridView

#! oh -> Out-Host
Get-Process | Out-Host -Paging
$io = Get-History
Out-Host -InputObject $io # 콘속에 기록되는 개체를 지정함

#! popd -> Pop-Location

#! ps -> Get-Process
Get-Process notepad | Format-List *

#- psedit -> Open-EditorFile                          0.2.0      Services.Comm…
#- pushd -> Push-Location                                        
#- pwd -> Get-Location                                           
#- r -> Invoke-History                                           
#- rbp -> Remove-PSBreakpoint                                    
#- rcjb -> Receive-Job                                           
#- rcsn -> Receive-PSSession                                     
#- rd -> Remove-Item                                             
#- rdr -> Remove-PSDrive                                         
#- ren -> Rename-Item                                            
#- ri -> Remove-Item                                             
#- rjb -> Remove-Job                                             
#- rm -> Remove-Item                                             
#- rmdir -> Remove-Item                                          
#- rmo -> Remove-Module                                          
#- rni -> Rename-Item                                            
#- rnp -> Rename-ItemProperty                                    
#- rp -> Remove-ItemProperty                                     
#- rsn -> Remove-PSSession                                       
#- rv -> Remove-Variable                                         
#- rvpa -> Resolve-Path                                          
#- sajb -> Start-Job                                             
#- sal -> Set-Alias                                              
#- saps -> Start-Process                                         
#- sasv -> Start-Service                                         
#- sbp -> Set-PSBreakpoint                                       
#- scb -> Set-Clipboard                               7.0.0.0    Microsoft.eme…
#- select -> Select-Object                                       
#- set -> Set-Variable                                           
#- shcm -> Show-Command                                          
#- si -> Set-Item                                                
#- sl -> Set-Location                                            
#- sleep -> Start-Sleep                                          
#- sls -> Select-String                                          
#- sort -> Sort-Object                                           
#- sp -> Set-ItemProperty                                        
#- spjb -> Stop-Job                                              
#- spps -> Stop-Process                                          
#- spsv -> Stop-Service                                          
#- start -> Start-Process                                        
#- stz -> Set-TimeZone                                7.0.0.0    Microsoft.eme…
#- sv -> Set-Variable                                            
#- tee -> Tee-Object                                             
#- type -> Get-Content                                           
#- where -> Where-Object                                         
#- wjb -> Wait-Job                                               
#- write -> Write-Output                                         
