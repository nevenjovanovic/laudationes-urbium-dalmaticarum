(: query LiLa for a description of lemma ID :)
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
(: address to which we are sending the queries :)
(: rewrite as function :)
(: from a db with lemmarefs call this, insert lemmata into w :)
declare function local:qlila($lemmaref){ 
(: must ensure that we have https:! :)
let $url := replace(($lemmaref || "?output=application%2Frdf%2Bxml"), "http", "https")
let $parsed := doc($url)//*:label/string()
return $parsed
};

let $list := (
let $dbname := "clarius-ep-maf" || "-xml"
for $w in db:open($dbname)//*:w[@lemmaRef]
let $lemma := $w/@lemmaRef/string()
group by $lemma
order by count($w) descending
return "| " || local:qlila($lemma) || " | [" || substring-after($lemma, "/data/id/") || "](" || $lemma || ") | " || count($w) || " | " )
let $head := "| Lemma | URI | Count |
| ---- | --- | --- |"
return ( $head , $list )