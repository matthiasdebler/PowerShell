#Welcher Adpater
Get-NetAdapter



#Konfigurieren der DNS Server IP-Adresse
Set-DnsClientServerAddress `
-InterfaceAlias "Ethernet0" `
-ServerAddresses 192.168.1.10



#Prüfen wir die Konfiguration
Get-NetIPConfiguration