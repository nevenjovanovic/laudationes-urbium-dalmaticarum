(: query LiLa for a description of lemma ID :)
(: do it from a list :)
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
(: address to which we are sending the queries :)
(: TODO from a file with lemmarefs call this, insert lemmata into w :)
let $url := ("UPIT?output=application%2Frdf%2Bxml")
let $list := ( "https://lila-erc.eu/data/id/lemma/101542" , "https://lila-erc.eu/data/id/lemma/121354")
for $l in $list
let $query := replace($url, "UPIT", $l)
let $parsed := (doc($query))

return $parsed//rdfs:label/string()
