// NAME: transl example usage

#import "@preview/transl:0.1.0": transl

#set text(font: "Arial", size: 12pt)

// DEBUG: Show final translation database structure
#import "@preview/transl:0.1.0": show-db
#context show-db("final")


= Translator Example

This document is a practical example of how _transl_ works. If you are seeing
the final PDF result, please refer to the `docs/assets/example.typ` source file
to understand it better.

// Set database example.yaml
#transl(data: yaml("langs.yaml"))


== Translating words

#set text(lang: "pt")
Love in Portuguese: #transl("love").

#set text(lang: "es")
Love in Spanish: #transl("love").

#set text(lang: "fr")
// There's no "fr" entry in database.
Love in French: #transl("amour", from: "fr").

Love in Italian: #transl("love", to: "it").


== Translating expressions

#set text(lang: "pt")
In Portuguese we say: #transl("i love you, my dear!")

#set text(lang: "es")
In Spanish we say: #transl("i love you, my dear!")

#set text(lang: "fr")
// There's no "fr" entry in database.
In French we say: #transl("je t'aime mon amour!", from: "fr")

In Italian we say: #transl("i love you, my dear!", to: "it")


== Translating whole sections

#set text(lang: "pt")
#transl("poem")

#set text(lang: "es")
#transl("poem")

#set text(lang: "fr")
// There's no "fr" entry in database.
#transl(from: "fr",
"L'amour est un feu qui brûle sans être vu,
c'est une blessure qui fait mal mais qu'on ne ressent pas;
c'est un contentement insatisfait,
c'est une douleur qui rend fou sans faire mal."
)

#transl("poem", to: "it")


== Translating across the content

#set text(lang: "it")
#show: doc => transl(
  "every .*? night", "know", "love you", "love", "we'll share",
  doc
)

I wanna love you \
And treat you right \
I wanna love you \
Every day and every night \
We'll be together \
With a roof right over our heads \
We'll share the shelter \
Of my single bed \
We'll share the same room, yeah \
For Jah provide the bread \

Is this love? Is this love? Is this love?\
Is this love that I'm feeling?\
Is this love? Is this love? Is this love?\
Is this love that I'm feeling?\
I wanna know, wanna know, wanna know now\
I got to know, got to know, got to know now\
I-I-I-I-I-I-I-I-I, I'm willing and able\
So I throw my cards on your table\


== Translating and tweaking

#set text(lang: "pt")
#context{
  let translation = transl("love", mode: str)
  
  translation = upper(translation.first()) + translation.slice(1)
  let color = red
  for letter in translation {
    text(fill: color, letter)
    color = if color == red {rgb(252, 169, 227)} else {red}
  }
}


== Translating context-free

// Command must have #transl(..expr, to, data)
#transl("love", to: "it", data: yaml("langs.yaml"))


== Translating with localization using Fluent

#import "@preview/transl:0.1.0": fluent

// Set normalization for a single language and get the "declaration" expression
#transl(
  "declaration",
  data: fluent("file!" + read("ftl/pt.ftl"), lang: "pt"),
  args: (tense: "past")
)

// Set normalization for more than one language
#transl(
  data: eval( fluent("ftl/", lang: ("pt", "en")) ),
  args: (tense: "past")
)

#transl("declaration")

#transl("declaration", args: (tense: "future"))