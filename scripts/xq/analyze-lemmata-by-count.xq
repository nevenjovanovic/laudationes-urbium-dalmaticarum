let $dbname := "clarius-ep-maf" || "-xml"
for $w in db:open($dbname)//*:w[@lemmaRef]
let $lemma := $w/@lemmaRef
group by $lemma
order by count($w) descending
return element res { element l { $lemma } , element c { count($w)} } 