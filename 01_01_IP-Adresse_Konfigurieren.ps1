#Welche NICs stehen zur Verfügung?
Get-NetAdapter



#Zuerst deaktivieren Sie DHCP
Set-NetIPInterface -InterfaceAlias "Ethernet0" -AddressFamily IPv4 -DHCP Disabled -PassThru



#Mit diesem Befehl konfigurieren Sie die IP-Adresse
New-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "Ethernet0" `
-IPAddress 192.168.1.10 -PrefixLength 24 -DefaultGateway 192.168.1.1



#Testen der Einstellung
Test-Connection 192.168.1.1