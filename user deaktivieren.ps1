
# Account inaktivieren
Set-ADObject -Identity:"CN=pruefer,OU=Benutzer,OU=Team Prüfer,OU=Teams,DC=int,DC=e-zuku,DC=de" -Replace:@{"userAccountControl"="8389122"} -Server:"Domcon01.int.e-zuku.de"
Get-ADUser -Identity pruefer



# Account inaktivieren
Set-ADObject -Identity:"CN=pruefer1,OU=Benutzer,OU=Team Prüfer,OU=Teams,DC=int,DC=e-zuku,DC=de" -Replace:@{"userAccountControl"="8389122"} -Server:"Domcon01.int.e-zuku.de"
Get-ADUser -Identity pruefer1


