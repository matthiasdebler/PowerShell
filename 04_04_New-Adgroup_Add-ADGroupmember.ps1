#Neue Gruppe erstellen

New-ADGroup -name "Marketing" -GroupScope DomainLocal

New-ADGroup -name "Logistik" -GroupScope Global



#Standardmäßig wird eine Sicherheitsgruppe erstellt "GroupCategory: Security"
Get-ADGroup "Marketing"

 

#Neue Gruppe mit mehr Informationen erstellen
New-ADGroup –Name 'Technik' `
-Description 'Sicherheitsgruppe fuer alle Technik Benutzer' `
-DisplayName 'Technik' `
-GroupCategory Security `
-GroupScope Global `
-SAMAccountName 'Technik' `
-PassThru



#Benutzer zur Gruppe hinzufügen
Add-ADGroupMember -Identity Technik -Members frabets, janschm -PassThru




#Hat es funktioniert? (Soweit OK, aber die Accounts waren eigens zu "suchen")
Get-ADGroupMember -Identity Technik 




#Das geht noch besser
New-ADGroup –Name 'Manager' `
-Description 'Sicherheitsgruppe fuer alle Manager' `
-DisplayName 'Manager' `
-GroupCategory Security `
-GroupScope Global `
-SAMAccountName 'Manager' `
-PassThru




#Erstellen Sie eine Variable
$ManagerArray = (Get-ADUser -Filter {Title -like "*Manager*" } `
-Properties Title).SAMAccountName




#Ist die Variable OK?
$ManagerArray



#Jetzt fügen Sie den Inhalt der Variablen der Gruppe hinzu
Add-ADGroupMember -Identity "Manager" -Members $ManagerArray -PassThru




#Hat es funktioniert?
Get-ADGroupMember -Identity Manager `
| Get-ADUser -Properties Title `
| Format-Table -auto SAMAccountName,Name,Title