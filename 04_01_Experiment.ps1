#Bereichsoperator

1..500



#Erstellen von 500 Schulungs-Accounts (Testsaccounts)
1..500 | ForEach-Object {New-ADUser -name "User$_" -AccountPassword `
(ConvertTo-SecureString -AsPlainText "DemoPass1!" -force) -Enabled:$TRUE}





#New-Aduser (Standard cmdlet für das erstellen eines Benutzers)
#ConvertTo-SecureString (Klartext wird in ein SecureString Format übersetzt)