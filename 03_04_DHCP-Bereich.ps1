#konfigurieren Sie einen IP-Bereich
Add-DhcpServerv4Scope -Name "corp.int" `
-ComputerName "dcsrv01" `
-Description "IP-Bereich für die Verteilung" `
-StartRange "192.168.1.1" `
-EndRange "192.168.1.254" `
-SubNetMask "255.255.255.0" `
-State Active `
-Type DHCP `
-PassThru





#Hat es funktioniert?
Get-DhcpServerv4Scope