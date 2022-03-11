declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
(: open a tokenized, normalized TEI XML file, get normalized form :)
(: find the normalized form in rdf of lemmatized text :)
(: from the normalized form get lemma URI for @lemmaRef :)
(: check whether there is previous or next word, for beginning and end :)
(: TODO insert into TEI XML document :)
declare variable $dbname := "delaudibusrhacusae" ;
for $w in db:open($dbname || "-xml")//tei:w[@norm]
let $form := $w/@norm/string()

let $citerdf := db:open($dbname || "-rdf")//rdf:Description[*:hasStringValue=$form]/@*:about/string()
let $lemma := db:open($dbname || "-rdf")//rdf:Description[@*:about=$citerdf]/*:hasLemma/@rdf:resource/string()

return if (not($citerdf[2])) then insert node attribute { "lemmaRef"} { $lemma } into $w
else()