#import "/src/lib.typ": transl
#set page(height: auto, width: auto, margin: 1em)
#transl(data: read("/docs/example/lang/ftl/pt.ftl"), lang: "pt")

#set text(lang: "pt")


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
  to: "pt",
  data: read("/docs/example/lang/ftl/pt.ftl"), lang: "pt"
)
#string.slice(0,3)-#string.slice(3)