#import "/src/lib.typ": transl, fluent, std
#set page(height: auto, width: auto)

#transl( data: yaml("/docs/example/langs.yaml") )
#transl( data: fluent("file!" + read("/docs/example/ftl/en.ftl"), lang: "pt") )

#set text(lang: "pt")

// Get declaration in past tense
In those days #transl("declaration", tense: "past")

// Get declaration in present tense — same as #transl("declaration")
Now #transl("declaration", tense: "present")

// Get declaration in future tense
And forever #transl("declaration", tense: "future")


// Panics with additional args when using std database
#let data = (data: yaml("/docs/example/langs.yaml"), to: "pt")
#assert-panic(
  () => transl("love", type: "romantic", ..data)
)