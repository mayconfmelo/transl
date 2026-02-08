#import "@preview/transl:0.2.0": transl

#set page(height: auto)
#set text(font: "Arial", size: 12pt)


= Translator Example


// Setting databases
#transl(data: yaml("lang/std.yaml")) // Standard database
#transl(data: yaml("lang/ftl.yaml")) // Fluent database
#transl(data: read("lang/pt-BR.ftl"), lang: "pt-BR") // individual Fluent file


== Retrieve translation
// Search translation database for the expression "love" from target language.

#set text(lang: "pt", region: "BR")
Portuguese: #transl("love").

#set text(lang: "es", region: none)
Spanish: #transl("love").

// #transl(from) equal to target language: get the expression itself.
#set text(lang: "fr")
French: #transl("amour", from: "fr").

Italian: #transl("love", to: "it"). // #transl(to) also set target language.


=== Retrieve sentence
// Translate an entire sentence.

#set text(lang: "pt", region: "BR")
#transl("I love you, my dear")!


=== Retrieve text block
// Get a chunk of text.

#set text(lang: "es", region: none)
#transl("poem")


=== Case detection
// Get UPPERCASE, Sentence, or original translation based on the expression form

Lower: #transl("love")

Sentence: #transl("Love")

Upper: #transl("LOVE")


== Translating ocurrencies within text
// #show rule automatically translating all ocurrencies of given expressions

#show: transl.with("hot", "passionate", "passion")

Latin peoples are culturally known as "hot" because, in general, they are
naturally more friendly, passionate, festive, and sensual persons. Their overall
stereotypes can be described by one word: passion --- passion for living and for
loving.


=== Translate text excerpts with case detection
// Get translation from Fluent database and #show pattern from standard database

#show: transl.with("much", from: "en", to: "it")

Lower: i love you so much!

Sentence: I love you so much!

Upper: I LOVE YOU SO MUCH!


== Localize translations
#set text(lang: "pt", region: "BR")


=== Using Fluent
// Substitute placeables and set localization cases and with additional arguments

#transl("declaration", name: "meu bem", tense: "past")

#transl("declaration", name: "meu amor")

#transl("declaration", name: "minha vida", tense: "future")


=== Using standard database
// Substitute placeables by additional arguments

#transl("Longing", name: "meu amor")...


== Use regular expressions
// Match expressions in database using regex

#transl("You.{3} b.*?l", to: "it") // matches "you're beautiful" expression


== Values retrieved


=== Context value
// Retrieve an opaque context()

#transl("passion")


=== Context-dependent string
// Allow to access string inside a context

#context {
  let string = transl("passion", mode: str)
  
  string.slice(0,3)
  "-"
  string.slice(3)
}


=== Plain string
// Retrieve just a string, without context

#let string = transl(
  "passion",
  to: "pt-BR",
  data: read("lang/pt-BR.ftl"), lang: "pt-BR"
)
#string.slice(0,3)-#string.slice(3)