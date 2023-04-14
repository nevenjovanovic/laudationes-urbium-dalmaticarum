(: create index of lemmata with number of occurrences / forms :)
declare variable $db := ( 
"nardino-situ-norm-lemma"
) ;
declare function local:link($uri){ 
if (starts-with($uri, "http")) then element a { 
attribute href { $uri }, $uri }
else $uri
 };
let $result := element table { 
for $l in db:open($db)//*:body//*:w[@lemma]
return if (not($l/@lemmaRef)) then element res { element ref { "URI deest: " || db:node-id($l) } , element lemma { $l/@lemma/string() } , element form { $l/@norm/string()}}
else
let $l1 := $l/@lemma/string()
let $lem := $l/@lemmaRef/string()
return element res { element ref { $lem } , element lemma { $l1 } , element form { $l/string() } }
}
let $result2 := element tbody {
for $res in $result/res
let $uri := $res/ref
group by $uri
return element tr { 
element td { distinct-values($res/lemma/string())} , 
element td { count($res/form)} ,
element td { local:link($uri) } , 
element td { $res/form/string()}
}
}
let $result3 := element tbody {
for $tr in $result2/tr
order by $tr/td[1]
return $tr
}
return element table {
  element thead {
    element tr {
      element td { "Lemma" },
      element td { "Quot"},
      element td { "URI" },
      element td { "Forma" }
    }
  },
  $result3
}
