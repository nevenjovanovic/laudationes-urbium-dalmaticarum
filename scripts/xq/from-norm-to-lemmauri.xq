declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
(: open a tokenized, normalized TEI XML file, get normalized form :)
(: find the normalized form in rdf of lemmatized text :)
(: from the normalized form get lemma URI for @lemmaRef :)
(: check whether there is previous or next word, for beginning and end :)
(: TODO insert into TEI XML document :)
for $w in db:open("laud-asirelli")//tei:w
let $w1 := $w/following-sibling::tei:*[1]
let $w0 := $w/preceding-sibling::tei:*[1]
let $form := $w/@norm/string()
let $citerdf := db:open("laud-asirelli-rdf")//rdf:Description[*:hasStringValue=$form]/@*:about/string()
let $form1 := if ($w1/@norm) then $w1/@norm/string() else $w1/string()
let $citerdf1 := db:open("laud-asirelli-rdf")//rdf:Description[*:hasStringValue=$form1]/@*:about/string()
let $form0 := if ($w0/@norm) then $w0/@norm/string() else $w0/string()
let $citerdf0 := db:open("laud-asirelli-rdf")//rdf:Description[*:hasStringValue=$form0]/@*:about/string()
let $lemmardf := db:open("laud-asirelli-rdf")//rdf:Description[@rdf:about=$citerdf and *:next[@rdf:resource=$citerdf1]]/@rdf:about/string()
let $lemmardf0 := db:open("laud-asirelli-rdf")//rdf:Description[@rdf:about=$citerdf and *:previous[@rdf:resource=$citerdf0]]/@rdf:about/string()
let $lemmanext := db:open("laud-asirelli-rdf")//rdf:Description[@rdf:about=$lemmardf]/*:hasLemma/@rdf:resource
let $lemmaprev := db:open("laud-asirelli-rdf")//rdf:Description[@rdf:about=$lemmardf0]/*:hasLemma/@rdf:resource
return if ($lemmanext or $lemmaprev ) then if ($form1) then insert node attribute { "lemmaRef"} { $lemmanext } into $w else insert node attribute { "lemmaRef"} { $lemmaprev } into $w
else()
