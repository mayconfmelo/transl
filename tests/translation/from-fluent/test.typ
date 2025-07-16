#import "/src/lib.typ": transl, fluent
#set page(height: auto, width: auto)
#set text(lang: "pt")
#transl( data: fluent("file!" + read("/docs/example/ftl/en.ftl"), lang: "pt") )

// Get declaration in past tense
#transl("declaration", args: (tense: "past"))

// Default tense is present
#transl("declaration")

// Get declaration in future tense
#transl("declaration", args: (tense: "future"))