// NAME: Translator
// IDEA: Support for regex also when showing == false

#import "utils.typ": show-db

/**
 * = Quick Start
 *
 * ```typ
 * #import "@preview/transl:0.1.0": transl
 * #transl(data: yaml("lang.yaml"))
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
 * expressions and #url("https://projectfluent.org/", "Fluent") localization.
 * This package have one main command, `#transl`, that receives one or more
 * expression strings, searches for each of them in its database and then
 * returns the translation for each one.
 * 
 * The expressions are the text to be translated, they can be simple words or
 * longer text excerpts, or can be used as identifiers to obtain longer text
 * blocks at once. Regular expression patterns are supported when _transl_ is
 * used in `show` rules.
 * 
 * All the conceptual structure of _transl_ and its idea is heavily inspired on
 * the great #univ("linguify") package.
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
  from: none,
  /** <- string
   * Initial origin language.**/
  to: auto,
  /** <- string | auto
   * Final target language — fallback to `#text.lang` when not set. **/
  data: none,
  /** <- yaml | dictionary
   * Translation file — see the `docs/assets/example.yaml` file.**/
  mode: context(),
  /** <- type
   * Type of value returned by _transl_: a `context()` or a `str` —
   * the latter requires `#context transl(mode: string)`. **/
  args: (:),
  /** <- dictionary
    * Fluent arguments used to customize the translation output. **/
  ..expr
  /** <- strings
   * Expressions to be translated. **/
) = {
  import "utils.typ"
  
  if expr.named() != (:) {panic("unexpected argument: " + repr(expr.named()))}
  
  let expr = expr.pos()
  let i18n = "std"
  let showing = if expr != () and type(expr.last()) == content {true} else {false}
  let body = if showing {expr.pop()} else {none}
  
  if data != none {
    if to != auto {mode = str}
    
    // Manage output of #fluent()
    i18n = data.at("i18n", default: "std")
    data = data.at("files", default: data)
    
    if not showing {
      // Insert data into the translation database
      if data != (:) {utils.db(add: i18n, data)}
      if mode != str {utils.db(add: "i18n", i18n)}
    }
    
    // Allows context-free use
    let curr-data = data
    data = (:)
    data.insert(i18n, curr-data)
    
  }
  
  // Change localization mechanism in the translation database
  // if i18n != data.at("i18n", default: "std") and not showing and mode != str {
  //   i18n = data.at("i18n", default: i18n)
  //   utils.db(add: "i18n", i18n)
  // }
  
  // Exits if given no expression
  if expr == () {return}
  
  
  // Get translations
  let get-data() = {
    let data = if data == none {utils.db().get()} else {data}
    let i18n = data.at("i18n", default: i18n)
    let default = data.at(i18n).at("default", default: "en")
    let to = if to == auto {text.lang} else {to}
    let result = ()
    let expr = expr
    
    // If target language is available in database
    if data.at(i18n).keys().contains(to) {
      // Resolve localization mechanism (feeds result array)
      if i18n == "std" {
        let available = data.at(i18n).at(to)
        
        // Translate all entries available when no expression given in show rule
        if showing and expr.len() == 1 { expr = data.at(i18n).at(to).keys() }
        
        for e in expr {
          let res = available.at(e, default: none)
          
          if res == none {panic("Translation not found: " + repr(e))}
          result.push(res)
        }
      }
      else if i18n == "ftl" {
        for e in expr {
          let res = utils.fluent-data(
            get: e,
            lang: to,
            data: data.at(i18n),
            args: args
          )
          
          if res == none {panic("Translation not found: " + repr(e))}
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
    // The context type
    let contxt = [#context()]
    
    if mode == str {get-data().at(1).join(" ")}
    else if mode.func() == contxt.func() {context get-data().at(1).join(" ")}
    else {panic("Invalid mode " + repr(mode))}
  }
}


// UTIL: Resolve Fluent data for translation database. Used inside #eval
/**
 * = Fluent Data
 * 
 * :fluent:
 * 
 * Fluent is a localization solution (i10n) developed by Mozilla that can easily
 * solve those wild language-specific variations that are tricky to fix in code,
 * like gramatical case, gender, number, tense, aspect, or mood. When used to
 * set `#transl(data)`, this function signalizes _transl_ to use its embed
 * Fluent plugin instead of the standard mechanism (YAML). It needs to
 * be wrapped in an `eval` to work properly.
**/
#let fluent(
  path,
  /** <- string
    * The path where the `ftl` files are stored in the project. **/
  lang: (),
  /** <- array | string
    * The languages used — each corresponds to _lang.ftl_ inside the `path`. **/
  args: (:)
  /** <- dictionary | none
    * Additional arguments passed to Fluent. **/
) = {
  let code = ```typst
    let langs = LANGS
    let data = (
      i18n: "ftl",
      files: (:),
    )
    
    for lang in langs {
      data.files.insert(lang, str(read(PATH + "/" + lang + ".ftl")))
    }
    
    data
  ```.text
  
  if type(lang) != array {lang = (lang,)}
  if type(lang) == () {panic("Missing #transl(lang) argument")}

  let scope = (
    PATH: repr(path),
    LANGS: repr(lang),
  )

  code.replace(regex("\b(" + scope.keys().join("|") + ")\b"), m => scope.at(m.text))
}

/** 
 * After setting Fluent as localization mechanism, _transl_ will use it from now
 * on. To go back to the default localization mechanism the `#std()` command
 * must be used:
 * 
 * :std:
**/
#let std(
  data: (:)
) = {
  (
    i18n: "std",
    files: (:),
  )
}

/// The `#std` command does not need to be wrapped in an `eval`.