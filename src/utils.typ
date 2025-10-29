// Retrieve Fluent data using wasm plugin
#let fluent(get, lang, data, args: (:)) = {
  let wasm = plugin("./linguify_fluent_rs.wasm")
  let source = data.at(lang)
  let config = cbor.encode((source: source, msg-id: get, args: args))
  
  cbor(wasm.get_message(config))
}


// Retrieve translation
#let translate(expr, from, to, data, args, showing) = {
  import "@preview/toolbox:0.1.0": storage, has
  
  assert.ne(data, (:), message: "Set #transl(data) option before use")
  
  let std = data.at("std", default: (:))
  let ftl = data.at("ftl", default: (:))
  
  // Return back expression (no translation needed)
  if from == to {return expr}
  
  
  if has.key(std.at(to, default: (:)), expr) {
    // Retrieve expr in standard database
    std
      .at(to, default: (:))
      .at(expr)
      .replace(regex("(?s)\{\{(.*?)\}\}"), m => {
        // Simple {{arg}} substitution
        let key = m.captures.at(0).trim().replace("$", "")
        
        if has.key(args, key) {args.at(key)} else {m.text}
      })
  }
  else {
    // Checks if expr is a regex with matches in std.at(to)
    let key = std
      .at(to, default: (:))
      .keys()
      .find( key => key.contains(regex("(?i)" + expr)) )
    
    if key != none {
      return std
        .at(to, default: (:))
        .at(key)
        .replace(regex("(?s)\{\{(.*?)\}\}"), m => {
          // Simple {{arg}} substitution
          let key = m.captures.at(0).trim().replace("$", "")
          
          if has.key(args, key) {args.at(key)} else {m.text}
        })
    }
    
    assert.ne(
      ftl, (:),
      message: "'" + expr + "' not found for '" + to + "' (no Fluent database)"
    )
    assert.ne(
      ftl.at(to, default: (:)), (:),
      message: "'" + expr + "' not found for '" + to + "' (no Fluent file loaded)"
    )
    
    // Retrieve expr in Fluent database
    let result = fluent(expr, to, ftl, args: args)
    
    if result != none {result}
    else {panic("'" + expr + "' not found for '" + to + "'")}
  }
}