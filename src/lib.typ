// NAME: Translator

#import "utils.typ": show-db

/** #v(1fr)#outline()#v(1.2fr)
#pagebreak()

= Quick Start

```typ
#import "@preview/transl:0.1.1": transl
#transl(data: yaml("lang.yaml"))

#set text(lang: "es")
// Get "I love you" in Spanish:
#transl("I love you")

#set text(lang: "it")
// Translate every "love" to Italian:
#show: doc => transl("love", doc)
```

= Description

Get comprehensive and contextual translations, with support for regular
expressions and #url("https://projectfluent.org/", "Fluent") localization.
This package have one main command, `#transl`, that receives one or more
expression strings, searches for each of them in its database and then
returns the translation for each one.

The expressions are the text to be translated, they can be simple words or
longer text excerpts, or can be used as identifiers to obtain longer text
blocks at once. Regular expressions are supported as string patterns — not
`#regex` elements.

All the conceptual structure of _transl_ and its idea is heavily inspired by
the great #univ("linguify") package.

= Options

:transl:
**/
#let transl(
  from: auto, /// <- string
    /// Initial origin language. |
  to: auto, /// <- string | auto
    /// Final target language — fallback to `#text.lang` if not set. |
  data: none, /// <- yaml | fluent | dictionary
    /// Translation file (see `docs/assets/example.yaml` file). |
  mode: context(), /// <- context() | str
    /// Type of value returned: an opaque context or string. |
  ..expr /// <- strings
    /// Expressions to be translated. |
) = {
  import "utils.typ"
  import "@preview/toolbox:0.1.0": storage, has
  
  let args = expr.named()
  let expr = expr.pos()
  let l10n = "std"
  let showing = if expr != () and type(expr.last()) == content {true} else {false}
  let body = if showing {expr.pop()} else {none}
  
  if data != none {
    let l10n
  
    if to != auto {mode = str}
    
    // Set l10n value
    if type(data) == dictionary {
      if not has.key(data, "l10n") {data.insert("l10n", "std")}
      
      l10n = data.l10n
      let _ = data.remove("l10n")
    }
    else if type(data) == str {
      let new = (:)
      let lang = args.at("lang", default: none)
      
      assert.ne(lang, none, message: "#transl(lang) option also required")
      new.insert(lang, data)
      
      l10n = "ftl"
      data = new
    }
    else {
      panic("Invalid database type: " + repr(type(data)))
    }
    
    if not showing and mode != str {
      storage.add(l10n, data, append: true, namespace: "transl")
      //storage.add("l10n", l10n, namespace: "transl")
    }
    
    // Allows context-free use
    let curr-data = data
    data = (:)
    data.insert(l10n, curr-data)
  }
  
  // Exits if given no expression
  if expr == () and not showing {return}
  
  
  // Get translations
  let get-data() = {
    let data = if data == none {utils.db().get()} else {data}
    let l10n = data.at("l10n", default: l10n)
    let default = data.at(l10n).at("default", default: "en")
    let to = if to == auto {text.lang} else {to}
    let result = ()
    let expr = expr
    
    if args != (:) and l10n == "std" {
      panic("Unexpected arguments: " + repr(args))
    }
    
    // If target language is available in database
    if data.at(l10n).keys().contains(to) {
      // Resolve localization mechanism (feeds result array)
      if l10n == "std" {
        let available = data.at(l10n).at(to)
        
        // Translate all entries available when no expression given in show rule
        if showing and expr.len() == 0 { expr = data.at(l10n).at(to).keys() }
        
        for i in range(expr.len()) {
          // if expr.at(i).starts-with("regex!") {
          //   expr.at(0) = available.keys().find(key => key.contains(re))
          // }
          
          // Try to use expression as string, then try to use it as regex pattern
          let res = available.at(
            expr.at(i),
            default: {
              let re = regex("(?i)" + expr.at(i))
              let key = available.keys().find(key => key.contains(re))
    
              if key != none {available.at(key)} else {key}
            }
          )
          if res == none {panic("Translation not found: " + repr(expr.at(i)))}
          
          result.push(res)
        }
      }
      else if l10n == "ftl" {
        for i in range(expr.len()) {
          let res = utils.fluent-data(
            get: expr.at(i),
            lang: to,
            data: data.at(l10n),
            args: args
          )
          
          if res == none {panic("Translation not found: " + repr(expr.at(i)))}
          if l10n == "ftl" and from != auto and showing {
            expr.at(i) = data
              .at("std")
              .at(from)
              .at(expr.at(i), default: expr.at(i))
          }
          
          result.push(res)
        }
      }
    }
    // If origin and target languages are the same
    else if from == to {result = expr}
    else {panic("Target language not found: " + repr(to))}
    
    return (expr, result)
  }
  
  
  // When using #show: transl or else #transl
  if showing {
    context {
      let (expr, translated) = get-data()
      let body = body
      
      for i in range(translated.len()) {
        let re = regex("(?i)" + expr.at(i))
        
        body = {
          // Substitute the expression every time across the content
          show re: it => {
            let result = translated.at(i)
            
            if it.text.first() != upper(it.text.first()) {result}
            else if it.text != result {upper(result.first()) + result.slice(1)}
            else if it != upper(it) {upper(result)}
          }
          body
        }
      }
      body
    }
  }
  else {
    // The context type
    let contxt = [#context()]
    
    if mode == str {get-data().at(1).join(" ")}
    else if mode.func() == contxt.func() {context get-data().at(1).join(" ")}
    else {panic("Invalid mode: " + repr(mode))}
  }
}