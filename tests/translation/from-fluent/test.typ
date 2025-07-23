#import "/src/lib.typ": transl, fluent
#set page(height: auto, width: auto)
#transl( data: fluent("file!" + read("/docs/example/ftl/en.ftl"), lang: "pt") )

#set text(lang: "pt")

// Get declaration in past tense
#transl("declaration", tense: "past")

// Default tense is present
#transl("declaration")

// Get declaration in future tense
#transl("declaration", tense: "future")