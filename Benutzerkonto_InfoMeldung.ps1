# Über diesen Mailserver wird vorher eine InfoMail gesendet
$MailSMTPServer='exchange01'

# Mailverteiler Empfaenger 
$MailRecipient= 'empfaenger@e-zuku.de'

# Folgender Betreff hat die InfoMail
$MailSubject= 'Benutzerkonten pruefer und pruefer1 sind ab sofort deaktiviert'

# Dieser Text steht in der InfoMail
$MailText= "Diese Information wurde abgesendet an $MailRecipient von $MailFrom über Mailserver $MailSMTPServer

           Benutzerkonten pruefer und pruefer1 sind ab sofort deaktiviert! "

# Dies ist der Absender der InfoMail
$MailFrom= 'ActiveDirectoryService@e-zuku.de'




Send-MailMessage -SmtpServer $MailSMTPServer -To $MailRecipient -From $MailFrom -Subject $MailRecipient -Body $MailText -Encoding ([System.Text.Encoding]::UTF8)
       



