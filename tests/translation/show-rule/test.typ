#import "/src/lib.typ": transl, fluent
#set page(height: auto, width: auto)
#transl(data: yaml("/docs/example/langs.yaml"))


// Translate all these expressions to Italian from now on
#set text(lang: "it")
#show: doc => transl(
  "every .*? night", "know", "love you",
  "love", "we'll share", doc
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


#transl(data: fluent("file!" + read("/docs/example/ftl/pt.ftl"), lang: "pt") )
// Get "cards" translation on Fluent database (Portuguese)
// Get the expression equivalent to "cards" in standard database (English)
// Translate all ocurrencies of the English expression to the Portuguese translation
#show: doc => transl("cards", from: "en", to: "pt", doc)

Is this love? Is this love? Is this love?\
Is this love that I'm feeling?\
Is this love? Is this love? Is this love?\
Is this love that I'm feeling?\
I wanna know, wanna know, wanna know now\
I got to know, got to know, got to know now\
I-I-I-I-I-I-I-I-I, I'm willing and able\
// This line must be: Então eu jogo minhas cartas na sua mesa (cards)
So I throw my cards on your table\

