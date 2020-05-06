# Testen der Installation der Gesamtstruktur
Import-Module ADDSDeployment
Test-ADDSForestInstallation `
-DomainName 'corp.int' `
-DomainNetBiosName 'CORP' `
-DomainMode 6 `
-ForestMode 6 `
-NoDnsOnNetwork `
-NoRebootOnCompletion





# Richtig, das Importieren des Moduls wäre nicht nötig. It's a habit ;-)!
# Die Nummer 6 bedeutet Gesamtstruktur-, und Domainfunktionslevel Win2012R2