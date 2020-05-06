#Erstellen Sie eine OU
New-ADOrganizationalUnit NewUsers


#Schauen wir uns die CSV-Liste vom HR an
Import-CSV ".\newusers.csv" | ogv



#Die Liste stimmt nicht mit den Powershell-Kriterien überein



#Schauen wir uns die Parameter von New-ADUser an
help New-ADuser



#Wir helfen uns mit zusätzlichen Tricks
Import-CSV ".\newusers.csv" | Select-Object Title, Department, City, State, Office, EmployeeID, `
    @{name='name';expression={($_.'First Name'.substring(0,3)+$_.'Last Name').substring(0,7).toLower()}}, `
    @{name='samAccountName';expression={($_.'First Name'.substring(0,3)+$_.'Last Name').substring(0,7).toLower()}}, `
    @{name='displayName';expression={$_.'First Name'+' '+$_.'Last Name'}}, `
    @{name='givenName';expression={$_.'First Name'}}, `
    @{name='surName';expression={$_.'Last Name'}}, `
    @{name='path';expression={'OU=NewUsers,DC=corp,DC=int'}} |
    Out-GridView



#Jetzt erstellen wir die Konten
Import-CSV ".\newusers.csv" | Select-Object Title, Department, City, State, Office, EmployeeID, `
    @{name='name';expression={($_.'First Name'.substring(0,3)+$_.'Last Name').substring(0,7).toLower()}}, `
    @{name='samAccountName';expression={($_.'First Name'.substring(0,3)+$_.'Last Name').substring(0,7).toLower()}}, `
    @{name='displayName';expression={$_.'First Name'+' '+$_.'Last Name'}}, `
    @{name='givenName';expression={$_.'First Name'}}, `
    @{name='surName';expression={$_.'Last Name'}} |
    New-ADUser -ChangePasswordAtLogon $true -Enabled $True -AccountPassword $(ConvertTo-SecureString "P@55word" -AsPlainText -Force) -Path 'OU=NewUsers,DC=corp,DC=int' -PassThru



#Wie kontrollieren Sie nun?
Get-ADObject -SearchBase "OU=NewUsers,DC=corp,DC=int" -filter *
Get-ADUser -Filter 'Office -eq "OWA"' | ogv