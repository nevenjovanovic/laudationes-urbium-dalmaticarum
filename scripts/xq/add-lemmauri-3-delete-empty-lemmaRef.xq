let $dbname := "delaudibusrhacusae" || "-xml"
for $w in db:open($dbname)//*:w[@lemmaRef=""]
let $lr := $w/@lemmaRef
return delete node $lr