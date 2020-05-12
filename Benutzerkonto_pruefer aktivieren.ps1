# Account aktivieren
Set-ADObject -Identity:"CN=pruefer,OU=Benutzer,OU=Team Pr�fer,OU=WG Teams,DC=int,DC=e-zuku,DC=de" -Replace:@{"userAccountControl"="8389120"} -Server:"Domcon01.int.e-zuku.de"
Set-ADObject -Identity:"CN=pruefer1,OU=Benutzer,OU=Team Pr�fer,OU=WG Teams,DC=int,DC=e-zuku,DC=de" -Replace:@{"userAccountControl"="8389120"} -Server:"Domcon01.int.e-zuku.de"



# Zufallspasswort generieren
$length = 8
$Password1 = (New-Guid).Tostring().replace(�-�,��).Substring((Get-Random �Minimum 0 �Maximum (31-$length)),$length)
$Password2 = (New-Guid).Tostring().replace(�-�,��).Substring((Get-Random �Minimum 0 �Maximum (31-$length)),$length)

#$Zufallszahl | Get-Member -MemberType Property





# Erstellen einer Variable mit dem "sicheren" Passwort
$newPassword1 = ConvertTo-SecureString -$Password1 -AsPlainText -Force
$newPassword2 = ConvertTo-SecureString -$Password2 -AsPlainText -Force
#$newPassword2 = ConvertTo-SecureString -String "Pass123!" -AsPlainText -Force


# Kennwort zur�cksetzen

Set-ADAccountPassword -Identity:"CN=pruefer,OU=Benutzer,OU=Team Pr�fer,OU=WG Teams,DC=int,DC=e-zuku,DC=de" -NewPassword:$newPassword1 -Reset:$true -Server:"Domcon01.int.e-zuku.de"
Set-ADAccountPassword -Identity:"CN=pruefer1,OU=Benutzer,OU=Team Pr�fer,OU=WG Teams,DC=int,DC=e-zuku,DC=de" -NewPassword:$newPassword2 -Reset:$true -Server:"Domcon01.int.e-zuku.de"


# Password muss bei n�chster Anmeldung ge�ndert werden

Set-ADUser -ChangePasswordAtLogon:$true -Identity:"CN=pruefer,OU=Benutzer,OU=Team Pr�fer,OU=WG Teams,DC=int,DC=e-zuku,DC=de" -Server:"Domcon01.int.e-zuku.de"
Set-ADUser -ChangePasswordAtLogon:$true -Identity:"CN=pruefer1,OU=Benutzer,OU=Team Pr�fer,OU=WG Teams,DC=int,DC=e-zuku,DC=de" -Server:"Domcon01.int.e-zuku.de"


# �ber diesen Mailserver wird vorher eine InfoMail gesendet
$MailSMTPServer='exchange01'

# Mailverteiler Empfaenger 
$MailRecipient= 'edv@e-zuku.de'

# Folgender Betreff hat die InfoMail
$MailSubject= 'Folgende Accounts wurden automatisch deaktiviert'

# Dieser Text steht in der InfoMail
$MailText= "Diese Information wurde abgesendet an $MailRecipient von $MailFrom �ber Mailserver $MailSMTPServer .

Die Benutzerkonten Pruefer und Pr�fer1 wurden aktiviert. Die Startpa�w�rter wurden automatisch erzeugt.
 
--------------------------------------------------------------------------------------------------------
 Das Start-Passwort f�r das Benutzerkonto pruefer  lautet :                          $Password1   
 Das Start-Passwort f�r das Benutzerkonto pruefer1 lautet :                         $Password2    
--------------------------------------------------------------------------------------------------------

Hinweis: Das Start-Pa�wort muss vom Benutzer bei der ersten Anmeldung ge�ndert werden.


Team EDV"

# Dies ist der Absender der InfoMail
$MailFrom= 'ActiveDirectoryService@e-zuku.de'

# Mail senden
Send-MailMessage -SmtpServer $MailSMTPServer -To $MailRecipient -From $MailFrom -Subject $MailRecipient -Body $MailText -Encoding ([System.Text.Encoding]::UTF8)
        # Start-Sleep -Seconds 3600



