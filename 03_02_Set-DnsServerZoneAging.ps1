#Aktivieren Sie den DNS-Alterungs- und Aufräumvorgang
Set-DnsServerScavenging -ScavengingState:$True `
-ScavengingInterval 1:00:00:00 `
-RefreshInterval 4:00:00:00 `
-NoRefreshInterval 4:00:00:00 `
-ApplyOnAllZones `
-PassThru




#Hat es funktioniert?
get-DnsServerZoneAging -Name corp.int