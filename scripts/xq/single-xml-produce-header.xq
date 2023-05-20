declare option output:indent "yes";
declare variable $path := "../../norm-tok-lem-w-lila-lemmata/clarius-d-maffei-1505-norm-lemma-sent.xml";
declare variable $editor := ( "Neven Jovanović, ORCID ", element a { attribute href { "https://orcid.org/0000-0002-9119-399X" }, "0000-0002-9119-399X"} );
declare variable $apotheca := ( element a { attribute href { "https://github.com/nevenjovanovic/laudationes-urbium-dalmaticarum" }, "Laudationes urbium Dalmaticarum" }, " (LaUrDal)" );
declare variable $texturl := "https://croala.ffzg.unizg.hr/eklogai/neolatina/1505-clarius-archiepiscopo/";

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
  element p { "Textus: " , element a { attribute href { $texturl } , $title } },
  element p { "Auctor: " || $author || ", Wikidata: " , element a { 
  attribute href {"https://www.wikidata.org/entity/" || $wikidata },
  $wikidata }},
  element p { "Editor: " , $editor },
element p { "Apotheca: " , $apotheca }
}
};
local:maintitle()