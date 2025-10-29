// NAME: Manual for transl

#import "@preview/min-manual:0.2.0": manual, arg, univ, url

#show: manual.with(
  title: "Translator",
  description: "Easy and simple translations for words and expressions",
  authors: "Maycon F. Melo <@mayconfmelo>",
  package: "transl:0.2.0",
  license: "MIT",
  logo: image("docs/assets/manual-logo.png"),
  from-comments: read("src/lib.typ"),
)


= User Guide


== Translation database <database>

The `#transl` searches and retrieve translation data from a database that must
be set before its use; the database available is always the one set earlier in
code. The translation database is split in 2 to store standard and Fluent
data separately.


=== Standard database
```typ
#transl(data: yaml("std.yaml"))
```

The standard database is a simple storage based on dictionaries: all data is
stored in the following structure:

```yaml
l10n: std

lang:
  expression: Translation
```

#arg("l10n: <- std")[Database type; `std` defines a standard database.]
#arg("lang: <- dictionary")[Language code.]
#arg("expression: <- string")[Expression to be retrieved by `#transl`.]


=== Fluent database
```typ
#transl(data: read("en.ftl"), lang: "en")
#transl(data: yaml("ftl.yaml"))
```

The Fluent database stores files used by Fluent in translation and localization.
There are two ways to insert data in a Fluent database: `#read` each FTL file
with its `lang` individually; or set the whole YAML database with all files
inside. A Fluent file follows the structure:

```fluent
identifier = Translation
```

While a YAML database that contains multiple files follows the structure:

```yaml
l10n: ftl

lang: |
  identifier = Translation
```

#arg("l10n: <- std")[Database type; `ftl` defines a Fluent database.]
#arg("lang: <- string")[Language code.]
#arg("identifier: <- string")[Fluent identifier used as expression by `#transl`.]

Using FTL files allow to store data for each language separately, while requires
each file to be imported manually with a `lang` option; and using a YAML database
requires all Fluent data to be in the same file, while allows to set the
entire database using one command. Also note that one is loaded by `#read`,
while the other by `#yaml`.


== Translation
```typ
#transl("expression")
```

After setting the database, just use _expressions_. The expression is the text
to be translated, searched in the database to return the proper translation.
If multiple expressions are used in the same command, all translations are
concatenated with spaces in between. An expression can also be a regular
expression, used to match one expression from the database.

```typ
#transl("expr.*n?", "expression", "expression")
```

For each expression, `#transl` searches it in the standard database; if not
found, tries to match `regex(expression)` in this database; and if not found,
search in the Fluent database.

Since Fluent files uses identifiers instead of expressions, regular expressions
and expressions with spaces and special characters are not supported.


== Original Language
```typ
#transl("expression", from: "en")
```

Defines the initial language of the expression, before translation. Allows to
return the expression itself when both `#transl(from, to)` options are equal.


== Target Language
```typ
#transl("expression", to: "pt")
```

Defines the language of the translation obtained. Fallback to current
`#text.lang` if not set.


== Translate all expression occurrences
```typ
#show: transl.with("expression")
```

When used in a `#show` rule, `#transl` automatically substitutes all occurrences
for each expression that follows it. If no expression is given, tries to retrieve
and use all expressions available in database for the current language.

To use expressions and Fluent data in `#show` rules, just store the rule
expression pattern in the standard database, under the same identifier but in
`#transl(from)` language.


== Localization arguments
```typ
#transl(arg: "Value")
```

Any arguments other than the default ones (see @options section) are treated as
additional localization arguments, they select localization cases (Fluent only)
and replace special `{{$arg}}` patterns in translated values retrieved.

#grid(columns: 2,
  pad(right: 3em)[
    #align(center)[*Typst*]
    
    ```typ
    #transl(
      "response",
      answer: "no",
      name: "John",
    )
    ```
  ],
  grid.vline(stroke: gray.lighten(60%)),
  pad(left: 2em)[
    #align(center)[*Fluent*]
    
    ```ftl
    response = { $answer ->
      [yes] I do know {{ $name }}
      [no] I don't know {{ $name }}
      [maybe] I don't remember any {{ $name }}
    }
    ```
  ],
)


== Ways to retrieve translations


=== Opaque context
```typ
#transl(mode: context(), "expression")
```

The translation database is stored in a `#state`, and therefore requires
`#context` to be accessed; this option provides the context needed to access it,
but makes `#transl` return opaque `context()` values that cannot be modified
later. Used as default when no `#transl(mode)` is set.


=== Context-dependent string
```typ
#context transl(mode: str, "expression")
```

The translation database is stored in a `#state`, and therefore requires
`#context` to be accessed; this option returns the translation without context
provided, this allows to access and modify the value but requires to manually set a
`#context` in code.


=== Plain string
```typ
#transl(to: "es", data: yaml("std.yaml"), "expression")
```

When both, database and target language, are directly known from the
command arguments, the translation is performed without requiring any
context.

The `#transl(data)` value used is not set to the database `#state`, and
therefore will not be available in later command uses.


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.

The Fluent support is a fork of a #univ("linguify") feature, and all the overall
project concept is heavily inspired in this great package.
