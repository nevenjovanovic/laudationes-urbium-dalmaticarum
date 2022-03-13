(: query LiLa for a description of lemma ID :)
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
(: address to which we are sending the queries :)
(: TODO from a file with lemmarefs call this, insert lemmata into w :)
let $url := ("https://lila-erc.eu/data/id/lemma/86983?output=application%2Frdf%2Bxml")

let $parsed := (doc($url))

return $parsed//rdfs:label/string()
