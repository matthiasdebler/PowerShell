#Wie finden Sie das richtige Modul für die Active Directory Installation?
Get-WindowsFeature -name *AD*




# Installieren der AD DS Komponenten
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature




# Hat es funktioniert?
Get-Command -Module ADDSDeployment | Format-Table Name