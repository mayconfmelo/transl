// NAME: Translator
// FIXME: utils.db()
// TODO: Support for Fluent
// TODO: Add example.ftl file in docs/
// TODO: Support for regex when showing == false (?)

/**
 * = Quick Start
 *
 * ```typ
 * #import "@preview/transl:0.1.0": transl
 * #transl(data: yaml("en.yaml"))
 * 
 * // Get "I love you" in Spanish:
 * #set text(lang: "es")
 * #transl("I love you")
 * 
 * // Translate every "love" to Italian:
 * #set text(lang: "it")
 * #show: doc => transl("love", doc)
 * ```
 * 
 * = Description
 * 
 * Get comprehensive and contextual translations, with support for regular
 * expressions. This package exports only one command, `#transl`, that receives
 * one or more expression strings, searches for each of them in its database and
 * then returns the translation for each one.
 * 
 * The expression can be a simple word or longer text excerpts that equalize to
 * the text to be translated, they can be also used as identifiers to obtain
 * longer text blocks; regular expression patterns are also supported when used
 * with `show` rules and can be passed as simple strings.
 * 
 * While this is not a fork, all tye conceptual structure of _transl_ is heavily
 * inspired on the famous #univ("linguify").
 * 
 * #pagebreak()
 * 
 * = Options
 * 
 * These are all the options and its defaults used by _min-book_:
 * 
 * :transl:
**/
#let transl(
  data: none,
  /** <- yaml | dictionary
   * Translation file — see the `docs/assets/example.yaml` file.**/
  from: none,
  /** <- string
   * Initial origin language.**/
  to: auto,
  /** <- string | auto
   * Final target language — fallback to `#text.lang` when not set. **/
  mode: context(),
  /** <- type
   * Type of value returned by _transl_: a `context()` or a `str` —
   * the latter requires `#context transl(mode: string)`. **/
  ..expr
  /** <- strings
   * Expressions to be translated. **/
) = {
  import "utils.typ"

  let expr = expr.pos()
  let showing = if expr != () and type(expr.last()) == content {true} else {false}
  let body = if showing {expr.pop()} else {none}
  
  // Insert data into the translation database
  if data != none {utils.db(add: "lang", data)}
  
  // Exits the function if given no expression
  if expr == () {return}
  
  
  let get-data() = {
    let data = utils.db().get()
    let default = data.at("default", default: "en")
    let to = if to == auto {text.lang} else {to}
    let results = ()
    let expr = expr
    
    // If target language is available in database
    if to in data.at("lang").keys() {
      let available = data.at("lang").at(to)
      
      // Translate entries available when no expression given
      if showing and expr.len() == 1 { expr = data.at("lang").at(to).keys() }
      
      for e in expr {
        let result = available.at(e, default: none)
        
        if result == none {panic("Translation not found: " + repr(e))}
        
        results.push(result)
      }
    }
    // If origin and target languages are the same
    else if from == to {results = expr}
    else {panic("Target language not found: " + repr(to))}
    
    return (expr, results)
  }
  
  // When using #show: transl or else #transl
  if showing {
    context {
      let (expr, translated) = get-data()
      let body = body
      
      for r in range(translated.len()) {
        let re = "(?i)" + expr.at(r)
        
        body = {
          // Substitute the text of each
          show regex(re): it => context {
            let result = translated.at(r)
            
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
    let contxt = [#context()]
    
    if mode == str {get-data().at(1).join(" ")}
    else if mode.func() == contxt.func() {context get-data().at(1).join(" ")}
    else {panic("Invalid mode " + repr(mode))}
  }
}