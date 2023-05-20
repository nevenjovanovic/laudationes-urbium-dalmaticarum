declare option output:indent "yes";
declare variable $path := "../../norm-tok-lem-w-lila-lemmata/clarius-d-maffei-1505-norm-lemma-sent.xml";

declare function local:table($wcount, $lemmacount){
element div {
  attribute class {"row"},
  element div { 
  attribute class {"col" }, 
  "Verba: "  , element span {
    attribute class {"tag text-dark bg-light"},
   $wcount } },
  element div { 
  attribute class {"col"},
  "Lemmata: " , element span {
    attribute class {"tag text-dark bg-light"},
   $lemmacount } }
}
};
declare function local:tablestat(){
let $doc := fetch:doc($path)
let $wcount := count($doc//*:w[not(*:w)])
let $lemmacount := count(distinct-values($doc//*:w/@lemma))
return local:table($wcount, $lemmacount)  
};
local:tablestat()