﻿#Der erste Schritt: den Root Key erstellen

#Diesen Befehl im produktivem Umfeld einsetzen (Wichtig 10h warten - Replikation)
Add-KdsRootKey -EffectiveImmediately



#Dieser Befehl ist für eine Testumgebung gedacht 
Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10)) 




#Erstellen Sie eine neue Gruppe
New-ADGroup -Name TestMSA `
-GroupScope DomainLocal `
-Description "Gruppe fuer Server von TestMSA" `
-DisplayName "Test gMSA Gruppe" `
-GroupCategory Security `
-SAMAccountName TestMSA `
-PassThru




#Dieser Gruppe fügen Sie nun die "Members" hinzu
Add-ADGroupMember -Identity TestMSA `
-Members "dcsrv01$","dcsrv02$" `
-PassThru




#Kontrolle
Get-ADGroupMember -Identity TestMSA




#Nun erstellen Sie einen neuen Account
New-ADServiceAccount -Name SvcAcnt1 `
-DNSHostName SvcAcnt1.corp.int `
-PassThru




#Der Account wird nun bearbeitet
Set-ADServiceAccount -Identity SvcAcnt1 `
-PrincipalsAllowedToRetrieveManagedPassword TestMSA `
-PrincipalsAllowedToDelegateToAccount TestMSA `
-PassThru




#Vor dem Ausführen dieses cmdlets müssen die Systeme neu gestartet werden (damit die Gruppenzugehörigkeit übernommen wird)
Invoke-Command -ComputerName dcsrv02 -ScriptBlock {Restart-Computer -Force}




#Installieren Sie den Service Account auf dem DCSRV02
Invoke-Command -ComputerName dcsrv02 -ScriptBlock {Install-ADServiceAccount -Identity SvcAcnt1}




#Kontrolle
Invoke-Command -ComputerName dcsrv02 -ScriptBlock {Test-ADServiceAccount -Identity SvcAcnt1}




#Jetzt können wir in den Diensten diesen Account für einen spezifischen Dienst auswählen