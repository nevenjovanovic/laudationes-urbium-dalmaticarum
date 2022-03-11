declare variable $db := ( 
"delaudibusrhacusae-xml", "/home/neven/Repos/laudationes-urbium-dalmaticarum/normalized/marulustarchaniota-ragusa-normalized.xml",
"delaudibusrhacusae-rdf", "/home/neven/Repos/laudationes-urbium-dalmaticarum/ttl/de-laudibus-rhacusae.rdf"
) ;
for $n in (1, 3)
return
db:create($db[$n], $db[$n + 1], (), map { 'ftindex': true(), 'chop': false(), 'intparse' : true() })
