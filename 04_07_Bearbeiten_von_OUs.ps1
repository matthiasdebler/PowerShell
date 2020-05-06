#Das AD hat keinen Befehl fuer OUs, um Inhalte zu verschieben
Get-Command *org*




#Wir muessen uns mit dem cmdlet get-adobject helfen. Was zeigt uns die Hilfe?
help Get-ADObject




#Suchen wir nach Accounts
Get-ADObject -SearchBase "OU=NewUsers,DC=corp,DC=int" -Filter *




#... nach Abteilung
Get-ADUser -Filter "department -eq 'Technik'"




#... nach Abteilung und Stadt
Get-ADUser -Filter "department -eq 'Technik' -and city -eq 'Bern'"



#Noch etwas besser aufgelistet...
Get-ADUser -Filter "department -eq 'Technik' -and city -eq 'Bern'"`
-Properties department, city | Select-Object name, city, department




#Nun verschieben wir diese zwei Accounts
Get-ADUser -Filter "department -eq 'Technik' -and city -eq 'Bern'"`
-Properties department, city | Move-ADObject -TargetPath "OU=Technik,OU=Bern,DC=corp,DC=int"




#Hat es funktioniert?
Get-ADObject -SearchBase "OU=Technik,OU=Bern,DC=corp,DC=int" -Filter *