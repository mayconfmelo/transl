#import "/src/lib.typ": transl, fluent
#import "/src/utils.typ": show-db
#set page(width: auto)

// Import data from standard (YAML) and Fluent mechanisms
#transl(data: yaml("/docs/example/langs.yaml"))
#transl(data: eval(fluent("/docs/example/ftl", lang: ("en", "pt"))))

// Show the final database, visualized as YAML
#context show-db()