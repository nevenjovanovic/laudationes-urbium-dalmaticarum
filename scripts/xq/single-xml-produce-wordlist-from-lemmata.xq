declare option output:indent "yes";
declare variable $path := "../../norm-tok-lem-w-lila-lemmata/clarius-d-maffei-1505-norm-lemma-sent.xml";
declare function local:link($string){
  element a {
    attribute href { replace($string, "https?:", "https:") },
    replace($string, "https?://", "")
  }
};
declare function local:table($body, $caption){
  element table {
    attribute class {"striped"},
    element caption {
      $caption
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
        element tfoot {
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
declare function local:context($w){
  for $ww in $w return element span { $ww/preceding-sibling::*:w[1] , $ww , $ww/following-sibling::*:w[1]  }
};
let $tabledeest :=
let $text := fetch:doc($path)//*:text
for $w in $text//*:w[@lemmaRef="DEEST"]
let $lemma := $w/@lemma
group by $lemma
let $result := element tr {
  element td { $lemma },
  element td { distinct-values($w/@lemmaRef/string())  },
  element td { count($w)},
  element td { local:context($w) }
}
let $table := element table {
  $result
} 
    for $r in $table/tr
order by lower-case($r/td[1])
return $r
let $tablesorted :=
let $text := fetch:doc($path)//*:text
for $w in $text//*:w[not(@ana) and not(@type) and not(@lemmaRef="DEEST")]
let $lemmaid := $w/@lemmaRef
group by $lemmaid
let $result := element tr {
  element td { distinct-values($w/@lemma/string()) },
  element td { local:link($lemmaid) },
  element td { count($w)},
  element td { local:context($w) }
}
let $table := element table {
  $result
} 
    for $r in $table/tr
order by lower-case($r/td[1])
return $r
return ( local:table($tabledeest, "1. Lemmata quorum URI desunt") , local:table($tablesorted, "2. Lemmata cum URI alphabetice") )