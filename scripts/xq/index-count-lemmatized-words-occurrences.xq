(: create index of lemmata with number of occurrences / forms :)
declare variable $db := ( 
"nardino-situ-norm-lemma"
) ;
let $v := db:open($db)//*:body//*:l
let $l := db:open($db)//*:body//*:w
let $countv := count($v)
let $countw := count($l)
let $countl := count(distinct-values($l/@lemma))
return ( $countv , $countw , $countl )