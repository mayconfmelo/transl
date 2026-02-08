#import "/src/lib.typ": transl
#set page(height: auto, width: auto, margin: 1em)
#transl(data: read("/docs/example/lang/pt-BR.ftl"), lang: "pt-BR")

#set text(lang: "pt", region: "br")


// Retrieve an opaque context()
Opaque: #transl("passion")

// Allow to access string inside a context
Contextualized:
#context {
  let string = transl("passion", mode: str)
  
  "-"
  for letter in string [#{letter}-]
}

// Retrieve just a string, without context
Plain: 
#let string = transl(
  "passion",
  to: "pt-BR",
  data: read("/docs/example/lang/pt-BR.ftl"), lang: "pt-BR"
)
#string.slice(0,3)-#string.slice(3)