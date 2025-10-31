#import "/src/lib.typ": transl
#set page(height: auto, width: auto, margin: 1em)

#transl(data: yaml("/docs/example/lang/std.yaml"))
#transl(data: read("/docs/example/lang/ftl/pt.ftl"), lang: "pt")

#set text(lang: "pt")


#transl("declaration", name: "meu bem", tense: "past")

#transl("declaration", name: "meu amor", tense: "present")

#transl("declaration", name: "minha vida", tense: "future")

#line()

// From standard database (basic support)
#transl("Longing", name: "meu amor")...