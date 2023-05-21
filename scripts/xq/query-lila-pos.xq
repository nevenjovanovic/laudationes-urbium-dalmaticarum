(: query LiLa for part of speech, using lemma ID :)
(: update database contents with lemma from LiLa, as value of @lemma :)

(: declare namespace for XML RDF result we get from LiLa :)
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace lila="http://lila-erc.eu/ontologies/lila/";

declare variable $lilaurl := <s>
<w lemma="a" lemmaRef="http://lila-erc.eu/data/id/lemma/86824" norm="ab">ab</w>
<w lemma="illyricus" lemmaRef="http://lila-erc.eu/data/id/lemma/140917" norm="Illyrica">Illyrica</w>
<w lemma="uolo" lemmaRef="http://lila-erc.eu/data/id/lemma/130745" norm="uoluisse">uoluisse</w>
<w lemma="Hirtius" lemmaRef="https://logeion.uchicago.edu/Hirtius" norm="Hirtium">Hirtium</w>
<w lemma="Zaptat" lemmaRef="DEEST" norm="Zaptat">Zaptat</w>
<pc>.</pc>
</s>;

(: function which does the work :)
declare function local:qlila($l){ 
if (starts-with($l, "https://lila-erc.eu")) then
let $url := ("QSTRING?output=application%2Frdf%2Bxml") 
let $query := replace($url, "QSTRING", string($l))
let $parsed := (doc($query))
let $result := $parsed//lila:hasPOS/@*:resource/string()
return $result
else "Not in LiLa"
};

(: the script using the function :)
for $w in $lilaurl/*:w
let $lr := $w/@lemmaRef/string()
let $l := replace($lr, "http:", "https:")
let $lem := local:qlila($l)
return $w transform with {
  insert node attribute pos { $lem } into .
}
