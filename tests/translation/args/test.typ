#import "/src/lib.typ": transl
#set page(height: auto, width: auto, margin: 1em)

#transl(data: yaml("/docs/example/lang/std.yaml"))
#transl(data: read("/docs/example/lang/ftl/pt.ftl"), lang: "pt")

#set text(lang: "pt")


#transl("declaration", nick: "meu bem", tense: "past")

#transl("declaration", nick: "meu amor", tense: "present")

#transl("declaration", nick: "minha vida", tense: "future")

// From standard database (simple arguments)
#transl("Longing", nick: "meu amor")...