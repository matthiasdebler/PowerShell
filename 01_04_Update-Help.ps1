#vorher
get-help get-service -exa


#Mit diesem cmdlet aktualsieren Sie die Hilfe-Dateien
update-help * -force



#nachher
get-help get-service -exa









#Sind die Systeme Mitglied der Domäne, kann folgendes cmdlet verwendet werden
Invoke-Command -ComputerName dcsrv01, dcsrv02 -ScriptBlock {update-help * -force}