declare option output:indent "yes";
declare variable $path := "../../norm-tok-lem-w-lila-lemmata/marulustarchaniota-ragusa-norm-lemma-sent.xml";
declare function local:link($string){
  element a {
    attribute href { replace($string, "https?:", "https:") },
    replace($string, "https?://", "")
  }
};
declare function local:table($body){
  element table {
    attribute class {"striped"},
    element caption {
      "Lemmata alphabetice"
    },
    element thead {
      element tr {
        element td {
          "Lemma"
        },
        element td {
          "Lemma URI"
        },
        element td {
          "Quoties?"
        },
        element td {
          "Contextus"
        }
      }
    },
    element tbody { $body }
  }
};
let $tablesorted :=
let $doc := fetch:doc($path)
let $text := $doc//*:text
for $w in $text//*:w[not(@ana) and not(@type)]
let $lemmaid := $w/@lemmaRef
group by $lemmaid
let $result := element tr {
  element td { distinct-values($w/@lemma/string()) },
  element td { local:link($lemmaid) },
  element td { count($w)},
  element td {
    for $ww in $w return element span { $ww/preceding-sibling::*:w[1] , $ww , $ww/following-sibling::*:w[1]  } }
}
let $table := element table {
  $result
} 
    for $r in $table/tr
order by lower-case($r/td[1])
return $r
return local:table($tablesorted)