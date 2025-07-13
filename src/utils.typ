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
#let type-check(arg, ..types, die: false) = {
  let contxt = [#context()].func()
  let match = false

  if types.pos().contains(type(arg)) {match = true}
  else if type(arg) == content and arg.func() == contxt {match = true}
  
  if die == false {return match}
  else if match == false {panic("Invalid value type: " + type(arg))}
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
      let val = val
      
      if add.contains(".") {
        let p = str(add).split(".")
        
        if add.ends-with("+") {
          p.last() = p.last().trim("+")
          let arr = curr.at(p.at(0), default: (:)).at(p.at(1), default: ())
          val = (..arr, val)
        }
        
        // Insert curr.at(p0)
        if curr.at(p.at(0), default: (:)) == (:) {
          curr.insert(str(p.at(0)), (:))
        }
        curr.at(p.at(0)).insert(p.at(1), val)
      }
      else {
        if add.ends-with("+") {
          add = add.trim("+")
          let arr = curr.at(add, default: ())
          val = (..arr, val)
        }
        curr.insert(str(add), val)
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