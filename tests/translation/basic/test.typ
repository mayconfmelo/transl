#import "/src/lib.typ": transl
#set page(height: auto, width: auto, margin: 1em)


// Setting databases
#transl(data: yaml("/docs/example/lang/std.yaml"))
#transl(data: yaml("/docs/example/lang/ftl.yaml"))
#transl(data: read("/docs/example/lang/pt-BR.ftl"), lang: "pt-BR")


// Search translation database for expression "love" in target language.

#set text(lang: "pt", region: "BR")
Portuguese: #transl("love").

#set text(lang: "es", region: none)
Spanish: #transl("love").

// #transl(from) equal to target language; get tue expression itself.
#set text(lang: "fr")
French: #transl("amour", from: "fr"). 

Italian: #transl("love", to: "it"). // #transl(to) also set target language.

#line()

#set text(lang: "pt", region: "BR")
Phrase: #transl("i love you, my dear")!

#line()

// Translate from Fluent database
#set text(lang: "es", region: none)
Fluent: #transl("hot")

#line()


#set text(lang: "pt", region: "BR")

Lower: #transl("love") // amor

Sentence: #transl("Love") // Amor

Upper: #transl("LOVE") // AMOR