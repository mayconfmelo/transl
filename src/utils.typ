// NAME: Utilities internal sub-module

// UTIL: Check if given required arguments are provided
#let required-args(..args) = {
  for arg in args.named().keys() {
    if args.named().at(arg) == none {
      panic("Missing required argument: " + arg)
    }
  }
}


// UTIL: Check if given value is of one of the types
#let required-types(arg, ..types, test: false) = {
  let match = false
  
  if type(arg) in types.pos() {
    match = true
  }
  
  if test == false {
    if match == false {
      panic("Invalid value type: " + type(arg))
    }
  }
  else {
    return match
  }
}


// UTIL: Manage and store data in the translation database (see USAGE)
#let db(
  add: none,
  get: none,
  del: none,
  upd: none,
  ..val
) = {
  let state-name = "min-book-configuration-storage"
  let this = state(state-name)
  let val = val.pos().at(0, default: none)
  
  // USAGE: utils.cfg(add: <any>)
  if add != none {
    this.update(curr => {
      if curr == none {curr = (:)}
      
      for entry in add.keys() {
        curr.insert(entry, add.at(entry))
      }
      curr
    })
  }
  // USAGE:  utils.cfg(del: <string>)
  else if del != none {
    this.update(curr => {
      if curr == none {curr = (:)}
      if del.contains(".") {
        let path = del.split(".")
        let _ = curr.at(path.at(0)).remove(str(path.at(1)), default: val)
      }
      else {
        let _ = curr.remove(str(del), default: val)
      }
      curr
    })
  }
  // USAGE: context utils.cfg(get: <string>, [default])
  else if get != none {
    return this.get().at(str(get), default: val)
  }
  // USAGE: utils.cfg(upd: <any>)
  else if upd != none {
    if type(val) != dictionary {
      panic("utils.config(upd) requires a dictionary: found " + type(upd))
    }
    this.update(val)
  }
  // USAGE: context utils.cfg()
  else {
    return this
  }
}