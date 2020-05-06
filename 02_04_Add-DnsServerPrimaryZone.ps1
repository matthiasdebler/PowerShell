#Prüfen, welche Zonen vorhanden sind
Get-DnsServerZone



#Erstellen einer Reverse-Lookup-Zone
Add-DnsServerPrimaryZone -NetworkID 192.168.1.0/24 `
-ReplicationScope 'Domain' `
-DynamicUpdate 'Secure' `
-PassThru



#Der PTR-Record für den DC kann mit folgendem Befehl erstellt werden (oder einem Neustart)
ipconfig /registerdns