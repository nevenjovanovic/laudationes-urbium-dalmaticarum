declare variable $db := ( 
"clarius-ep-maf-xml", "/home/neven/Repos/laudationes-urbium-dalmaticarum/normalized/clarius-d-maffei-1505-normalized.xml",
"clarius-ep-maf-rdf", "/home/neven/Repos/laudationes-urbium-dalmaticarum/ttl/clarius-epistula-maffei.rdf"
) ;
for $n in (1, 3)
return
db:create($db[$n], $db[$n + 1], (), map { 'ftindex': true(), 'chop': false(), 'intparse' : true() })
