#Erstellen Sie eine neue OU
New-ADOrganizationalUnit -Name "Technik"



#Kurzer Check
Get-ADOrganizationalUnit -Filter *



#Noch zwei neue OU's
New-ADOrganizationalUnit -Name "Bern"

New-ADOrganizationalUnit -Path "OU=Bern,DC=corp,DC=int" -Name "Technik"




#Nun besteht ein Problem - wo ist die OU Technik?
Get-ADOrganizationalUnit Technik




#Was meint die Hilfe dazu?
help get-ADOrganizationalUnit 
help Get-ADOrganizationalUnit -Parameter identity





#Indentifizieren der OUs
Get-ADOrganizationalUnit -Identity "OU=Technik,OU=Bern,DC=corp,DC=int"
Get-ADOrganizationalUnit -Identity "OU=Technik,DC=corp,DC=int"



#Error, richtig ich muss den Pfad angeben
Remove-ADOrganizationalUnit "Technik" 



#Access is denied, wir sind aber als admin angemeldet
Remove-ADOrganizationalUnit "OU=Technik,DC=corp,DC=int" 



#Mit welchem Account sind Sie angemeldet?
whoami




#Schauen wir uns die OU genau an
get-ADOrganizationalUnit "OU=Technik,DC=corp,DC=int" -Properties *




#Wir setzten den Wert auf False
Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion`
$false -Identity "OU=Technik,DC=corp,DC=int"




#Jetzt können wir die OU löschen
Remove-ADOrganizationalUnit "OU=Technik,DC=corp,DC=int"




#Hat es funktioniert?
Get-ADOrganizationalUnit -Identity "OU=Technik,DC=corp,DC=int"