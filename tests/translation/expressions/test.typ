#import "/src/lib.typ": transl
#set page(height: auto, width: auto)
#transl(data: yaml("/docs/example/langs.yaml"))


// Expression in Portuguese
#set text(lang: "pt")
In Portuguese we say: #transl("i love you, my dear!")

// Expression in Spanish
#set text(lang: "es")
In Spanish we say: #transl("i love you, my dear!")

// There's no "fr" entry in database.
#set text(lang: "fr")
In French we say: #transl("je t'aime mon amour!", from: "fr")

// Expression in Italian
In Italian we say: #transl("i love you, my dear!", to: "it")
