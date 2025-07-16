#import "/src/lib.typ": transl
#set page(height: auto, width: auto)
#transl(data: yaml("/docs/example/langs.yaml"))


#set text(lang: "pt")
// Receives a contextualized string and manipulates it
#context{
  let translation = transl("love", mode: str)
  
  translation = upper(translation.first()) + translation.slice(1)
  let color = red
  for letter in translation {
    text(fill: color, letter)
    color = if color == red {rgb(252, 169, 227)} else {red}
  }
}


// Receives a normal string
// Command must have #transl(..expr, to, data)
#transl("love", to: "it", data: yaml("/docs/example/langs.yaml"))