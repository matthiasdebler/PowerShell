#Wir müssen den Bereich ändern
Set-ADGroup "Marketing" -GroupScope Universal



#Kontrolle
Get-ADGroup "Marketing"




#Können wir auch von Global zu Domainlocal ändern?
Set-ADGroup "Logistik" -GroupScope DomainLocal




#... das geht nur über einen Zwischenschritt
Set-ADGroup "Logistik" -GroupScope Universal
Set-ADGroup "Logistik" -GroupScope Domainlocal



#Hat es funktioniert?
Get-ADGroup "Logistik"



#Wir brauchen eine neue Sicherheitsgruppe, kein Problem!
New-ADGroup -name "HR" -GroupScope Global



#Wir müssen die Accounts vom HR in diese Gruppe einfügen. Welche Benutzer sind im HR?
Get-ADUser -filter {department -eq "HR"} -Properties department




#Perfekt, dann können wir das gleich erweitern (Error, warum? Add-ADGroupMember will eine Liste mit Gruppen, nicht Members)
Get-ADUser -filter {department -eq "HR"} -Properties department | Add-ADGroupMember "HR" 




#OK, so geht's
Get-ADUser -filter {department -eq "HR"} -Properties department | Add-ADPrincipalGroupMembership -memberOf "HR"




#Hats geklappt?
Get-ADGroupMember "HR" | Get-ADUser -Properties department




#In welchen Gruppen ist Andrea Steiner?
Get-ADPrincipalGroupMembership "AndStei"