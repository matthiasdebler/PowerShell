# Dieses Kennwort wird bei allen Accounts gesetzt die Mitglied der angegebenen Sicherheitsgruppe sind
$AccountNewPassword= 'hausmeister123#'

# Alle Accounts die Mitlied dieser Sicherheitsgruppe sind erhalten das neu Kennwort
$ADSecurityGroup= 'Mobile_User_Passwort'

# Über diesen Mailserver wird vorher eine InfoMail gesendet
$MailSMTPServer='exchange01'

# An diesen Mailverteiler wird die InfoMail gesendet 
$MailRecipient= 'fzsg-hausmeister@frohe-zukunft.de'
# $MailRecipient= 'matthias.debler@frohe-zukunft.de'

# Folgender Betreff hat die InfoMail
$MailSubject= 'Neues Kennwort für Mobile Benutzer'

# Dieser Text steht in der InfoMail
$MailText= "Das neue Kennwort für alle mobilen Benutzer ist      $AccountNewPassword       - Bitte nachtragen unter E-Mail/im Menü oben rechts/Kontoeinstellungen/Servereinstellungen/Kontoeinstellungen. "

# Dies ist der Absender der InfoMail
$MailFrom= 'edv@frohe-zukunft.de'




function Set-ADUserPassword
{
<#
.Synopsis
   Set-MobileUserPassword
.DESCRIPTION
   Ändert das Kennwort aller Benutzer in der angegebenen AD Sicherheitsgruppe
.EXAMPLE
   Set-MobileUserPassword -AccountNewPassword '!NeuesKennwort#1' -ADSecurityGroup 'Mitarbeiter' -MailRecipient 'Mailverteiler' -MailSubject 'Neues Kennwort' -MailText "Das neues Kennwort für die Mobile-User ist $AccountNewPassword - Bitte nachtragen unter E-Mail/rechts oben im Menü/Kontoeinstellungen/Servereinstellungen/Kontoeinstellungen" -Verbose
#>

    [CmdletBinding()]
    Param
    (
        # Hilfebeschreibung zu Param1
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$false,
                   Position=0)]
        [string]$AccountNewPassword,
                
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$false,
                   Position=1)]
        [string]$ADSecurityGroup,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$false,
                   Position=2)]
        [string]$MailSMTPServer,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$false,
                   Position=3)]
        [string]$MailRecipient,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$false,
                   Position=4)]
        [string]$MailFrom,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$false,
                   Position=5)]
        [string]$MailSubject,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$false,
                   Position=6)]
        [string]$MailText
    )

    Begin
    {
        Send-MailMessage -SmtpServer $MailSMTPServer -To $MailRecipient -From $MailFrom -Subject $MailRecipient -Body $MailText -Encoding ([System.Text.Encoding]::UTF8)
        # Start-Sleep -Seconds 3600
        Start-Sleep -Seconds 5
        [array]$Accounts=Get-ADGroupMember -Identity $ADSecurityGroup    
    }
    Process
    {
        Foreach ($Account in $Accounts){
            try
            {
               Set-ADAccountPassword $Account -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$AccountNewPassword" -Force) -ErrorAction Continue
               Write-Verbose "Successfully chnaged Password for Account $($Account.name)"
            }
            catch
            {
                $_
            }
        }
    }
}

Set-ADUserPassword -AccountNewPassword $AccountNewPassword -ADSecurityGroup $ADSecurityGroup -MailSMTPServer $MailSMTPServer -MailRecipient $MailRecipient -MailFrom $MailFrom -MailSubject $MailSubject -MailText $MailText -Verbose