#import "/src/lib.typ": transl
#import  "@preview/toolbox:0.1.0": storage

#set page(width: auto, height: auto, margin: 1em)


// Set standard YAML database
#transl(data: yaml("/docs/example/lang/std.yaml"))

// Set Fluent YAML database (with l10n: ftl)
#transl(data: yaml("/docs/example/lang/ftl.yaml"))

// Include Fluent files for individual languages in database
#transl(data: read("/docs/example/lang/ftl/pt.ftl"), lang: "pt")


// Show the final database, visualized as YAML
#context raw(
  lang: "yaml",
  yaml.encode(storage.get(namespace: "transl"))
)