// NAME: Manual for transl

#import "@preview/min-manual:0.1.1": manual, arg, univ, url

#show: manual.with(
  title: "Translator",
  description: "Easy and simple translations for words and expressions",
  authors: "Maycon F. Melo <https://github.com/mayconfmelo>",
  package: "transl:0.1.0",
  license: "MIT",
  logo: image("docs/assets/manual-logo.png"),
  from-comments: read("src/lib.typ")
)

= Use Cases

== Standard Translation Database

```typ
#transl(data: yaml("lang.yaml"))
```

Before any proper translation, it is required to insert some translation data
into _transl_, so it will know what to translate. These data imports are
cumulative: newer entries overrides the older ones, so its possible to add
multiple files (e.g., one for each language) for better organization. See
`docs/example/lang.yaml` to learn more about the structure of a standard
translation database.


== Fluent Translation Database

```typ
#transl(
  data: eval( fluent(data: "path", lang: ("pt", "es")) )
)
```

To enable the support for Fluent localization, is necessary to set the database
using `#fluent`, which can resolve the paths to the `flt` files and read them.
In the code above, the files `path/pt.ftl` and `path/es.ftl` will be added to the
standard translation database. Because of some Typst limitations on `#read`, it
is required to wrap it inside an `#eval` command for now; alternatively, passing
`"file!"` followed by tye Fluent code itself (as string) gets rid of the
evaluation:

```typ
#transl(
  data: fluent(data: "file!" + read("path/pt.ftl"), lang: "pt")
)
```

Note that this syntax allows to import data for only one language at a time.
After set Fluent, all next _transl_ command will use it as localization
mechanism; to go back to the standard localization mechanism, use:

```typ
#transl( data: std(yaml("lang.yaml")) )
```

The YAML database can be ommited if there is already a standard translation
database registered.


== Get Translation

```typ
#transl("expression")
```

The _expressions_ are simple strings that contains the text to be translated, or
regular expression patterns that matches it. If more than one expression is
given at the same time, their translations are concatenated with a space in
between. When gets an expression, _transl_ tries to find it as string and then
as a regex pattern if not find anything:

```typ
#transl("exp.*?n")
```

When searching the database, the first entry that matches the regex will be used.
Fluent databases does not support regex patterns because the expressions must be
text identifiers.




== Set Original Language

```typ
#transl("expression", from: "en")
```

Defines the initial language of the expression, before translation. This is an
optional feature used to get the expression itself as translation when
`#transl(from) == #transl(to)`.


== Set Target Language

```typ
#transl("expression", to: "pt")
```

Defines the language of the translation obtained. This is an optional feature
that fallback to the current `#text.lang` when not set.


== Using Show Rules

```typ
#show: doc => transl("expression", doc)
```

When used as a `show` rule, _transl_ allows to automatically translate all the
expressions found in the text without using the command `#transl` each time.
When multiple expression values are given, each one of them is replaced for its
translation in the text; and when no expression is given, all available entries
in the database for the language selected are used — see the
`docs/example/lang.yaml` for more information.


== Get Contextual String

```typ
#context transl("expression", mode: str)
```

This allows to manage and tweak the translated string received from _transl_
without the barrier of the `context()` value: when using contextual data, _transl_
returns an opaque `context()` value that cannot be manipulated; but this mode
returns the contextualized string value instead, used inside a `#context` block.

This is useful for package mantainers that need to manipulate or use the
translated value in elements that only allows string arguments, like `#raw()`.


== Context-Free Translations

```typ
#transl("expression", to: "pt", data: yaml("lang.yaml"))
```

To completely get rid of all `context()` is required to set
`#transl(..expr, to, data)` in the same command, this way all needed information
is available at once and nothing needs to be contextually retrieved. This returns
a simple `string` without the need of any additional `#context` blocks.


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.

The Fluent support is a fork of a #univ("linguify") feature, and all the overall
project concept is heavily inspired in this great package.