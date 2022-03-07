let $parent := replace(file:parent(static-base-uri()), '/scripts/xq/', '') 
let $path := $parent || "/data/" 
return db:create("laudationes", $path, (), map { 'ftindex': true(), 'chop': false(), 'intparse' : true(), 'autooptimize' : true(), 'updindex' : true() })