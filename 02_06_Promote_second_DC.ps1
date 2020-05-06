#Sie wissen nicht mehr wie das Modul heißt?
Get-WindowsFeature `
| Where-Object {$_.DisplayName -match "Active" `
-AND $_.InstallState -eq "Available" } `
| Format-Table -auto DisplayName,Name,InstallState



#Mit diesem Befehl installieren Sie das AD-Domain-Services-Modul
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature



#Testen Sie die DC-Installation
Test-ADDSDomainControllerInstallation `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainName "corp.int" `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SiteName "Default-First-Site-Name" `
-SysvolPath "C:\Windows\SYSVOL" `
-InstallDns:$true `
-Force



#Installieren Sie nun den DC in die bestehende Gesamtstruktur/Domäne
Install-ADDSDomainController `
-SkipPreChecks `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainName "corp.int" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SiteName "Default-First-Site-Name" `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true