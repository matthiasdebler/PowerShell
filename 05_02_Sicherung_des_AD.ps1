#Installation des Features
Install-WindowsFeature -Name Windows-Server-Backup



#Hilfe aktualisieren
Update-Help -Module WindowsServerBackup -Force



#Eine Liste mit Modulen, aber nicht gerade hilfreich
gcm -mod WindowsServerBackup



#Das ist schon etwas besser
gcm -Module WindowsServerBackup | Sort Noun,Verb | ft -auto Verb,Noun



#Wir starten mit einer neuen Policy
$newWbPol = New-WBPolicy



#Welche Laufwerke sind vorhanden
Get-WBVolume -AllVolumes



#Die Sicherung von Laufwerk C
$wbVol = Get-WBVolume -VolumePath C:



#Das Laufwerk wird in die Policy eingetragen
Add-WBVolume -Policy $newWBPol -Volume $wbVol



#Die folgenden 2 Variablen dienen dazu, Dateien ein- und auszuschliessen
$incFSpec = New-WBFileSpec -FileSpec "C:\Temp"
$excFSpec = New-WBFileSpec -FileSpec "C:\ps" -Exclude



#Diese beiden Variablen werden zur Policy hinzugefuegt
Add-WBFileSpec -Policy $newWBPol -FileSpec $incFSpec
Add-WBFileSpec -Policy $newWBPol -FileSpec $excFSpec



#Schauen wir uns schnell den Inhalt der Variablen an
$newWBPol



#Eine neue Variable mit dem Inhalt der Disks
$wbDisks = Get-WBDisk



#Auf welche Disk schreibe ich das Backup?
$wbDisks



#Ich füge der Policy die Disk zu
$wbTarget = New-WBBackupTarget -Disk $wbDisks[1]
Add-WBBackupTarget -Policy $newWBPol -Target $wbTarget



#Mit BMR...
Add-WBBareMetalRecovery -Policy $newWBPol



#Ist auf "True"
$newWBPol



#Inkl. Systemstate
Add-WBSystemState -Policy $newWBPol



#Zeitplan
Set-WBSchedule -Policy $newWBPol -Schedule 12:00,20:00



#... ist nun erstellt
$newWBPol



#Bevor Sie  noch eine Aenderung an der Policy machen, sichern Sie die Einstellungen in der folgenden Variablen.
$curPol = Get-WBPolicy



#Keine Sicherung überschreiben
Set-WBPolicy -Policy $newWBPol -AllowDeleteOldBackups:$False -Force



#Hat es funktioniert?
Get-WBPolicy



#Lets go!
Start-WBBackup -Policy $newWBPol