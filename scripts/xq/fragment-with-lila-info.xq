(: TODO pc :)
(: TODO LiLa link :)
(: TODO enclisis :)
let $fragment := <s>
<w lemma="pontifex" lemmaRef="http://lila-erc.eu/data/id/lemma/118418" norm="pontificem">Pontificem</w>
               <w lemma="magnus" lemmaRef="http://lila-erc.eu/data/id/lemma/111319" norm="maximum">Maximum</w>
                  <w norm="tuamque" ana="enclisis"><w lemma="tuus" lemmaRef="http://lila-erc.eu/data/id/lemma/129328">tuam</w><w lemmaRef="https://lila-erc.eu/data/id/lemma/131416" join="left">que</w></w>
               <w lemma="amplitudo" lemmaRef="http://lila-erc.eu/data/id/lemma/88782" norm="amplitudinem">Amplitudinem</w>
               <w lemma="dirigo" lemmaRef="http://lila-erc.eu/data/id/lemma/99575" norm="directae">directae</w>
               <pc>,</pc>
               <w lemma="utpote" lemmaRef="http://lila-erc.eu/data/id/lemma/131106" norm="utpote">utpote</w>
</s>
for $w in $fragment/*:w
let $summary := element summary {
  attribute class { "outline"},
  $w/string()
}
let $info := element div {
  attribute class { "card"},
  element p { $w/@lemmaRef/string() },
  element p { $w/@lemma/string() },
  element p { $w/@norm/string() }
}
return element details {
  attribute class { "dropdown" },
  $summary ,
  $info
}
