let $db := "laud-lemm-sent"
for $doc in db:get($db)
let $path := db:path($doc)
let $titlest := $doc//*:titleStmt
let $creation := $doc//*:profileDesc/*:creation
order by $path
return element div {
  attribute class {"row"},
  element div { 
  attribute class {"col"},
  $path },
  element div { 
  attribute class {"col"},
  $titlest },
  element div { 
  attribute class {"col"},
  $creation }
}