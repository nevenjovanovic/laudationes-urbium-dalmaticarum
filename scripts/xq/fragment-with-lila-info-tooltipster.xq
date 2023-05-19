declare option output:indent "yes";
(: transform for inclusion in html to use with tooltipster :)
(: the lemma data are in separate div / span structure, referred to by the attribute :)
(: TODO enclisis :)
declare function local:link($string){
  element a {
    attribute href { replace($string, "https?:", "https:") },
    replace($string, "http://lila-erc.eu/data/", "")
  }
};
for $paragraph in db:get("laurdal-lila")//*[name()=("p", "closer")]
for $fragment in $paragraph/*:s
let $infospan :=
for $w in $fragment/*
return if ( $w/name() = "w" and $w[*:w] ) then
let $wid := random:uuid()
let $word := element w { 
attribute class {"annotation"} ,
attribute data-tooltip-content { "#" || $wid } , 
$w/string() }
let $info := element span {
  attribute id { $wid },
  for $ww in $w/*:w[@lemma] return ( element span { 
  attribute class { "lilac_formType" } ,
  $ww/@norm/string() },  
  element span { 
  attribute class { "lilac_lemma" } ,
  $ww/@lemma/string() },
  element span { 
  attribute class { "lilac_info2" } ,
  local:link($ww/@lemmaRef/string())
   }
)
}
return element tr {
  element td { $info },
  element td { $word }
}
else if ( $w/name() = "w" and $w[@lemma]) then
let $wid := random:uuid()
let $word := element w { 
attribute class {"annotation"} ,
attribute data-tooltip-content { "#" || $wid } , 
$w/string() }
let $info := element span {
  attribute id { $wid },
  element span { 
  attribute class { "lilac_formType" } ,
  $w/@norm/string() },  
  element span { 
  attribute class { "lilac_lemma" } ,
  $w/@lemma/string() },
  element span { 
  attribute class { "lilac_info2" } ,
  local:link($w/@lemmaRef/string())
   } 
}
return element tr {
  element td { $info },
  element td { $word }
}
else if ($w/name() = "w") then
 element tr { 
 element td { "" },
 element td { element pc { $w/string() } }
}
else if ( $w/name() = "pc" ) then
 element tr { 
 element td { "" },
 element td { element pc { $w/string() } }
}
return element div { 
element div {
  attribute class { "lilac_lemmaInfo" },
  $infospan/td[1]/*
},
element div {
  attribute class { "row"},
  element div {  
  attribute class {"col"},
  $infospan/td[2]/*
}
}
}
