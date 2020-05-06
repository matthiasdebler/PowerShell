#Welche Einstellungen sind vorhanden?
Get-ADDefaultDomainPasswordPolicy



#Das ist vielleicht zu restriktiv - eine mögliche Anpassung
Get-ADDefaultDomainPasswordPolicy -Identity corp.int `
| Set-ADDefaultDomainPasswordPolicy -LockoutThreshold 10 `
-LockoutDuration 00:10:00 `
-LockoutObservationWindow 00:10:00 `
-MinPasswordLength 10 `
-MaxPasswordAge 100.00:00:00 `
-PassThru



#Sind die Einstellungen korrekt?
Get-ADDefaultDomainPasswordPolicy