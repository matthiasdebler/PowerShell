# Installation der Gesamtstruktur
Install-ADDSForest `
-DomainName 'corp.int' `
-DomainNetBiosName 'CORP' `
-DomainMode 6 `
-ForestMode 6 `
-NoDnsOnNetwork `
-SkipPreChecks `
-Force





# Um die Passwortabfrage für das "Verzeichnis-Dienste-Wiederherstellungs-Passwort" zu umgehen, können wir folgende Variable einsetzten
# $pwdSS = ConvertTo-SecureString -String 'P@ssw0rd!' -AsPlainText -Force
# mit dem Paramter -SafeModeAdministratorPassword