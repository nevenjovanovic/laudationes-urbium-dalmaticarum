(: create DB laud-lemm-sent from files tokenized into sentences and words :)
let $parent := replace(file:parent(static-base-uri()), '/scripts/xq/', '') 
let $path := $parent || "/normalized-tokenized-lemmatized/" 
return db:create("laud-lemm-sent", $path, (), map { 'ftindex': true(), 'intparse' : true(), 'autooptimize' : true(), 'updindex' : true() })