#import "@preview/transl:0.0.0": transl

#set page(height: auto)
#set text(font: "Arial", size: 12pt)


= Translator Example
This file is compiled from `docs/example/main.typ` file, check it also.


// Setting databases
#transl(data: yaml("lang/std.yaml")) // standard database
#transl(data: yaml("lang/ftl.yaml")) // Fluent database
#transl(data: read("lang/ftl/pt.ftl"), lang: "pt") // individual Fluent file


== Retrieve translation
// Search translation database for expression "love" in target language.

#set text(lang: "pt")
Portuguese: #transl("love").

#set text(lang: "es")
Spanish: #transl("love").

// #transl(from) equal to target language; get tue expression itself.
#set text(lang: "fr")
French: #transl("amour", from: "fr"). 

Italian: #transl("love", to: "it"). // #transl(to) also set target language.


=== Phrase
// Translate an entire phrase.

#set text(lang: "pt")
#transl("i love you, my dear")!


=== Text block
// Get a chunk of text using a identifier.

#set text(lang: "es")
#transl("poem")


== Translating ocurrencies within text
// #show rule automatically translates the all ocurrencies of given expressions

#show: transl.with("hot", "passionate", "passion", to: "es")

The Spanish word "hot" is quite interesting; it has the same meaning as in
English: to be warm --- boiling, even ---, but hot has a kind of
spicyness to it that cannot be well explained. Hispanic peoples are often called
hot because of their passion --- in fact, a synonym for to possess passion is
"passionate" (burning, fiery). Interestingly, in Portuguese there is no word
similar to hot; the word "caloroso" is the literal translation (to be warm) but
has a different meaning of amiability or excitement.

In this text the words hot, passionate, and passion were automatically translated.

=== Use identifier expression
// Get translation from Fluent and #show rule pattern from standard database

#show: transl.with("much", from: "en", to: "it")

I love you so much!


== Localize translations
#set text(lang: "pt")


=== Using Fluent
// Use localization cases and substitute variables based on additional arguments

#transl("declaration", nick: "meu bem", tense: "past")

#transl("declaration", nick: "meu amor")

#transl("declaration", nick: "minha vida", tense: "future")


=== Using standard database
// Substitute variables based on additional arguments

#transl("longing", nick: "meu amor")...


== Use regular expressions
// Match expressions in database using regex

#transl("you.{3} b.*?l", to: "it") // you're beautiful


== Values retrieved


=== Context value
// Retrieve an opaque context()

#transl("passion")


=== Context-dependent string
// Allow to access string inside a context

#context {
  let string = transl("passion", mode: str)
  
  "-"
  for letter in string [#{letter}-]
}


=== Plain string
// Retrieve just a string, without context

#let string = transl(
  "passion",
  to: "pt",
  data: read("lang/ftl/pt.ftl"), lang: "pt"
)
#string.slice(0,3)-#string.slice(3)