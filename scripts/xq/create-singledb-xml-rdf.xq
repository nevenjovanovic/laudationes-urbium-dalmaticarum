declare variable $db := ( 
"nardino-situ-xml", "/home/neven/Repos/laudationes-urbium-dalmaticarum/normalized/nardinocelinese-desituiadrae-normalized.xml",
"nardino-situ-rdf", "/home/neven/Repos/laudationes-urbium-dalmaticarum/ttl/nardinus-celineus-carmen-de-situ-iadrae-1508.rdf"
) ;
for $n in (1, 3)
return
db:create($db[$n], $db[$n + 1], (), map { 'ftindex': true(), 'chop': false(), 'intparse' : true() })
