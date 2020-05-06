#Einen neuen Benutzer erstellen, aber wie?
help New-ADUser



#Einen Benutzer erstellen
New-ADUser BobS


#Account ist erstellt, aber das Konto ist inaktiv (Passwort fehlt) und hat nicht viele Zusatzinfos
Get-ADUser -Identity Bobs 



#Löschen Sie den Account
Remove-ADUser -Identity BobS



#Erstellen Sie den Account nochmals
New-ADUser -name BobS -Department Technik -Title Manager -City Luzern


#Ja, die Angaben stimmen, aber er ist immer noch inaktiv
Get-ADUser -Identity Bobs -Properties City, Department, Title

 

#Löschen Sie den Account
Remove-ADUser -Identity BobS



#Erstellen Sie den Account nochmals (das geht nicht, aber warum?)
New-ADUser -name BobS -Department Technik -Title Manager -City Luzern -AccountPassword "Pass123!"



#Was sagt die Hilfe dazu?
help new-ADUser -Parameter accountpassword
help ConvertTo-SecureString



#Löschen Sie den Account nochmals
Remove-ADUser -Identity BobS



#Erstellen Sie eine Variable mit dem "sicheren" Passwort
$newPassword = ConvertTo-SecureString -String "Pass123!" -AsPlainText -Force



#Jetzt erstellen Sie den Account nochmals
New-ADUser -name BobS -Department Technik -Title Manager -City Luzern -AccountPassword $newPassword -Enabled $TRUE



#Sie kontrollieren nochmals
Get-ADUser -Identity Bobs -Properties City, Department, Title