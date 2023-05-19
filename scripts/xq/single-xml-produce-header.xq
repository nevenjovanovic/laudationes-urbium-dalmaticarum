declare option output:indent "yes";
declare variable $path := "../../norm-tok-lem-w-lila-lemmata/marulustarchaniota-ragusa-norm-lemma-sent.xml";

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
declare function local:maintitle(){
let $doc := fetch:doc($path)//*:teiHeader//*:titleStmt
let $title := normalize-space($doc/*:title/string())
let $author := normalize-space($doc/*:author/*:persName[@xml:lang="la"]/string())
let $wikidata := $doc/*:author/*:idno[@type="wikidata"]/string()
return element div {
  attribute class { "col"},
  element h1 {
    attribute class {"text-success"} ,
    "Index verborum operis: " || $title
  },
  element p { "Textus: " || $title },
  element p { "Auctor: " || $author || ", Wikidata: " , element a { 
  attribute href {"https://www.wikidata.org/entity/" || $wikidata },
  $wikidata }}
}  
};
local:maintitle()