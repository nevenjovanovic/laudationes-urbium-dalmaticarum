(: Basic information on word and lemmata counts :)
let $dbname := "clarius-ep-maf" || "-xml"
let $wcount := count(db:open($dbname)//*:w)
let $norefcount := count(db:open($dbname)//*:w[not(@lemmaRef)])
let $lemmacount := count(distinct-values(db:open($dbname)//*:w[@lemmaRef]/@lemmaRef))
return "Word count: " || $wcount || ". 

Not lemmatized: " || $norefcount || ". 

Lemmata count: " || $lemmacount || "."