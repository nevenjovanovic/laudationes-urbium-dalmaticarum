(: query LiLa for a description of lemma ID :)
(: do it from a list :)
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
(: address to which we are sending the queries :)
(: rewrite as function :)
(: TODO from a file with lemmarefs call this, insert lemmata into w :)
declare function local:qlila($l){ 
let $url := ("QSTRING?output=application%2Frdf%2Bxml") 
let $query := replace($url, "QSTRING", string($l))
let $parsed := (doc($query))
return $parsed//rdfs:label/string()
};
let $dbname := "laud-lemm-sent"
let $list := db:get($dbname)//*:w[starts-with(@lemmaRef, "http://lila-erc.eu")]
for $w in $list
let $ref := $w/@lemmaRef/string()
let $l := replace($ref, "http:", "https:")
let $lem := local:qlila($l)
return insert node attribute { "lemma"} { $lem } into $w
