#import "/src/lib.typ": transl
#import  "@preview/nexus-tools:0.1.0": storage

#set page(width: auto, height: auto, margin: 1em)


// Set Standard database (YAML)
#transl(data: yaml("/docs/example/lang/std.yaml"))

// Set Fluent database (YAML)
#transl(data: yaml("/docs/example/lang/ftl.yaml"))

// Include Fluent files (single language) in database
#transl(data: read("/docs/example/lang/pt-BR.ftl"), lang: "pt-BR")


// Show the final database, visualized as YAML
#context raw(
  lang: "yaml",
  yaml.encode(storage.get(namespace: "transl"))
)