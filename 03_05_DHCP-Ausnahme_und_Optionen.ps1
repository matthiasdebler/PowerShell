#Erstellen Sie eine Ausnahme für einen gewissen IP-Bereich
Add-DhcpServerv4ExclusionRange -ScopeID "192.168.1.0" `
-ComputerName "dcsrv01" `
-StartRange "192.168.1.1" `
-EndRange "192.168.1.90" `
-PassThru




#Nun konfiguieren Sie noch die DHCP-Optionen
Set-DhcpServerv4OptionValue -ScopeID "192.168.1.0" `
-ComputerName "dcsrv01" `
-DnsDomain "corp.int" `
-DnsServer "192.168.1.10" `
-Router "192.168.1.1" `
-PassThru





#Als zusätzliche Kontrolle...
Get-DhcpServerv4OptionValue -ScopeId "192.168.1.0"