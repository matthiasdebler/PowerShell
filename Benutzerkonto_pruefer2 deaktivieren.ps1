
# Account inaktivieren
Set-ADObject -Identity:"CN=pruefer,OU=Benutzer,OU=Team Prüfer,OU=WGFZ Teams,DC=int,DC=frohe-zukunft,DC=de" -Replace:@{"userAccountControl"="8389122"} -Server:"Domcon01.int.frohe-zukunft.de"
Get-ADUser -Identity pruefer



# Account inaktivieren
Set-ADObject -Identity:"CN=pruefer1,OU=Benutzer,OU=Team Prüfer,OU=WGFZ Teams,DC=int,DC=frohe-zukunft,DC=de" -Replace:@{"userAccountControl"="8389122"} -Server:"Domcon01.int.frohe-zukunft.de"
Get-ADUser -Identity pruefer1


