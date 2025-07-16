#import "/src/lib.typ": transl
#set page(height: auto, width: auto)
#transl(data: yaml("/docs/example/langs.yaml"))


#set text(lang: "pt")
Love in Portuguese: #transl("love").

#set text(lang: "es")
Love in Spanish: #transl("love").

#set text(lang: "fr")
// There's no "fr" entry in database.
Love in French: #transl("amour", from: "fr").

Love in Italian: #transl("love", to: "it").


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