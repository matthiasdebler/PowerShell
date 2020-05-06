#Wir brauchen einen DHCP Server - erster Schritt ist, die Rolle zu installieren
Install-WindowsFeature -ComputerName dcsrv01 `
-Name DHCP `
-IncludeAllSubFeature `
-IncludeManagementTools



#Wir müssen das DHCP-Commit ausführen (im ServerManager oder mit CMD Tools)



#Nun aktivieren Sie den DHCP Server im AD
Add-DhcpServerInDC -DnsName 'dcsrv01' -PassThru




#Jetzt noch die Kontrolle
Get-DhcpServerSetting