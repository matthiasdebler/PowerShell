# Liste mit allen DC's
Get-ADDomainController -Filter * | Format-Table Name, Domain, Forest, Site, IPv4Address, OperatingSystem, OperationMasterRoles -AutoSize



# Account unlock
Read-Host "Enter the user account to unlock" | Unlock-ADAccount



# Password reset
Set-ADAccountPassword (Read-Host 'User') -Reset



#Wie viel Diskplatz ist auf allen Domänencontrollern vorhanden?
Get-ADDomainController -Server dcsrv01 -Filter * | ForEach-Object {Get-WmiObject -Class win32_logicaldisk -ComputerName $_.name | ft systemname,deviceid,freespace -AutoSize}



#get domain/forest info
get-addomain | fl *
get-adforest | fl *