(: list files and titles, format as HTML table :)
declare function local:table($cells){
  element tr {
    for $c in $cells return element td {
      $c
    }
  }
};
element table {
for $d in db:open("laudationes")//*:TEI
let $file := db:path($d)
let $title := $d/*:teiHeader//*:titleStmt/(*:title,*:author)
let $titletxt := for $t in $title return normalize-space($t)
return local:table( ($file, string-join($titletxt, "; ")))
}