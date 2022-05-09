(: create a db from the lemmatized file :)
declare variable $db := ( 
"nardino-situ-norm-lemma", "nardinocelinese-desituiadrae-norm-lemma.xml"
) ;
let $parent := replace(file:parent(static-base-uri()), '/scripts/xq/', '') 
let $path := $parent || "/norm-lemmatized/" 
return db:create($db[1], $path  || $db[2], (), map { 'ftindex': true(), 'chop': false(), 'intparse' : true() })
