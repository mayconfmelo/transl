#import "/src/lib.typ": transl, fluent, std
#set page(height: auto, width: auto)
#transl( data: fluent("file!" + read("/docs/example/ftl/en.ftl"), lang: "pt") )

#set text(lang: "pt")

// The same as #transl("declaration", tense: "present")
#transl("declaration")