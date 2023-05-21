(: read local XML file :)
(: query LiLa for part of speech, using lemma ID :)
(: return statistics on POS, frequency :)

(: declare namespace for XML RDF result we get from LiLa :)
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace lila="http://lila-erc.eu/ontologies/lila/";

declare option output:indent "yes";

declare variable $path := "../../norm-tok-lem-w-lila-lemmata/nardinocelinese-desituiadrae-norm-lemma-sent.xml";

(: function which does the work :)
declare function local:qlila($l){ 
if (starts-with($l, "https://lila-erc.eu")) then
let $url := ("QSTRING?output=application%2Frdf%2Bxml") 
let $query := replace($url, "QSTRING", string($l))
let $parsed := (doc($query))
let $result := $parsed//lila:hasPOS/@*:resource/string()
return $result
else "Deest in LiLa"
};


(: for HTML links :)
declare function local:link($url, $string){
  if ($url = "Deest in LiLa") then
  "Deest in LiLa"
  else
  element a {
    attribute href { $url },
    $string
  }
};

(: create table: lemma, POS, context :)
declare function local:datatable(){
let $result :=
let $doc := fetch:doc($path)//*:text
for $w in $doc//*:w[not(@ana)]
let $lemma := $w/@lemma/string()
let $lr := $w/@lemmaRef/string()
let $l := replace($lr, "http:", "https:")
let $pos := local:qlila($l)
return element tr {
  element td { element tr { $lemma } },
  element td { $pos }
}
return element table {
  $result
}};

let $rows := element tbody {
for $t in local:datatable()/*:tr
let $pos := $t/td[2]
group by $pos
order by $pos
return element tr {
  element td { local:link($pos, replace($pos, "https?://lila-erc.eu/ontologies/", "")) },
  element td { 
  attribute class { "text-right" },
  sum ( for $l in $t/td[1] 
  let $string := $l/tr/string()
  group by $string
  order by $string
  return count($string)
)
},
  element td { 
  attribute class { "text-right" },
  count($t) }

}
}
return element table {
  attribute class { "striped" },
  element caption {
    "Partes orationis in opere"
  },
  element thead {
    element tr {
      element td { "Pars orationis" },
      element td { 
      attribute class { "text-right" },
      "Quot lemmata?" },
      element td { 
      attribute class { "text-right" },
      "Quoties in opere?" }
    }
  },
  $rows
}