#Einen A-Record erstellen
Add-DnsServerResourceRecord -ZoneName "corp.int" `
-A `
-Name websrv01 `
-IPv4Address 192.168.1.20 `
-CreatePtr `
-PassThru



#Wir brauchen noch einen Alias
Add-DnsServerResourceRecord -ZoneName "corp.int" `
-CName `
-Name wds `
-HostNameAlias wdssrv01.corp.int `
-PassThru



#Nun haben Sie die Idee erhalten




#Sind die Einträge vorhanden?
Get-DnsServerResourceRecord -ZoneName "corp.int"




#Das geht aber noch schöner...
Get-DnsServerResourceRecord -ZoneName "corp.int" | where-Object {$_.recordtype -eq "A"}