#Wie viele AD-Objekte sind vorhanden?
Get-ADUser -filter * | Measure-Object



#Eine erste Suche
Get-ADUser -Filter * -properties * | where-object {$PSItem.city -eq "Luzern"} | Select-Object name,department,title



#Wie lange dauert diese Suche? Wir konzentrieren uns auf 'TotalSeconds'
measure-command {Get-ADUser -Filter * -properties * | where-object {$PSItem.city -eq "Luzern"} | Select-Object name,department,title}



#So erhalten wir gleich die Sekunden
(measure-command {Get-ADUser -Filter * -properties * | where-object {$PSItem.city -eq "Luzern"} | Select-Object name,department,title}).TotalSeconds



#Nun passen wir unsere Suche an und messen die Zeit erneut
Get-ADUser -Filter {city -eq "Luzern"} -Properties * | Select-Object name,department,title
(measure-command {Get-ADUser -Filter {city -eq "Luzern"} -Properties * | Select-Object name,department,title}).TotalSeconds



#Und nochmals eine Anpassung der Suche - die Zeit wird erneut gemessen
Get-ADUser -filter {city -eq "Luzern"} -Properties name, department, title | select-object name, department, title
(measure-command {Get-ADUser -filter {city -eq "Luzern"} -Properties name, department, title | select-object name, department, title}).TotalSeconds





#Je präziser Sie Ihre Suche erstellen, umso schneller erhalten Sie das Resultat. Was wäre wohl bei einem AD mit 50.000 Objekten?