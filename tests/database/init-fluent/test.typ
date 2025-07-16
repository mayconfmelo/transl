#import "/src/lib.typ": transl, fluent
#import "/src/utils.typ": show-db

// Import multiple Fluent files
#transl(
  data: eval( fluent("/docs/example/ftl", lang: ("en", "pt")) )
)

// Import single Fluent file
#transl(
  data: fluent("file!" + read("/docs/example/ftl/en.ftl"), lang: "en")
)