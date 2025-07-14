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
#import "@preview/transl:0.1.0": transl
#transl(data: yaml("lang.yaml"))
```

Before any proper translation, is required to insert some translation data
into `transl`, so it will know what to translate. These data imports are
cumulative: newer entries overrides the older ones, so its possible to add
multiple files (e.g., one for each language) for better organization. See
the `docs/assets/example.yaml` file to learn more about the structure of a
translation database.


== Fluent Translation Database

```typ
#import "@preview/transl:0.1.0": transl, fluent
#transl(
  data: eval( fluent(data: "path", lang: ("pt", "es")) )
)
```

To enable the support for Fluent localization, is necessary to set the database
using `#fluent`, that resolves the paths to all the `flt` files and reads them.
In the code above, the files `path/pt.ftl` and `path/es.ftl` will be added to the
translation database. Because of some Typst limitations on `#read`, it is
required to wrap it inside an `#eval` command for now.

After set to Fluent, every _transl_ command from now on will use it as
localization mechanism, to go back to the standard localization mechanism, use:

```typ
#import "@preview/transl:0.1.0": transl, std
#transl( data: std(yaml("lang.yaml")) )
```

The YAML database can be ommited if there os already a standard translation
database registerd.


== Get Translation

```typ
#import "@preview/transl:0.1.0": transl
#transl("expression")
```

The _expressions_ are simple strings that contains the text to be translated.
If more than one expression is given at tue same time, its translations are
returned together, separated by space.


== Set Original Language

```typ
#import "@preview/transl:0.1.0": transl
#transl("expression", from: "en")
```

Defines the initial language of the expression, before translation. This is an
optional feature used to get tye expression itself as translation when
`#transl(from) == #text.lang`. The expression can be a single word or an text
excerpt.


== Set Target Language

```typ
#import "@preview/transl:0.1.0": transl
#transl("expression", to: "pt")
```

Defines the language of the translation obtained for of the expression given.
This is an optional feature that fallback to the current `#text.lang` when no
set.


== Using Show Rules

```typ
#import "@preview/transl:0.1.0": transl
#show: doc => transl("expression", doc)
```

This way of using _transl_ allows to automatically translate the expressions
found in the text, without using the command `#transl` each time. When multiple
expression values are given, each one of them is replaced for its translation
in tue text; and when no expression is given, all available entries in the
database for the language selected are used. Tue expressions can also be regular
expression patterns (`string`) — though in this case the translation in the
database must be idenficied by the regex pattern instead of the text that would
match it — see the `docs/assets/example.yaml` for more information.


== Get Contextual String

```typ
#import "@preview/transl:0.1.0": transl
#context transl("expression", mode: str)
```

This allows to manage and tweak the translated string received from _transl_
without the barrier of `context()`, but to use it is required to wrap all the
code that modifies the translated string in a `context` block. This is useful
for package mantainers that need to manipulate or to use the translated value in
elements that only allows `string` arguments, like `#raw()`.


== Context-Free Translations

```typ
#import "@preview/transl:0.1.0": transl
#transl("expression", to: "pt", data: yaml("lang.yaml"))
```

To completely get rid of all `context()` is required to set
`#transl(..expr, to, data)` in tue same command, this way all needed information
is available at once and nothing needs to be contextually retrieved. This returns
a simple `string` without the need of any additional `context` blocks.


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.

The Fluent support is a fork of a #univ("linguify") feature, and all the overall
project concept is heavily inspired in this great package.