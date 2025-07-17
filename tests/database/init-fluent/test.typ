#import "/src/lib.typ": transl, fluent
#import "/src/utils.typ": show-db


// Import multiple Fluent files
#let code = fluent("/docs/example/ftl", lang: ("en", "pt"))
#let multiple = eval(code)
// Import a single Fluent file
#let single = fluent("file!" + read("/docs/example/ftl/en.ftl"), lang: "en")

#assert.eq(
  type(code), str, message: "Must be string: " + repr(code)
)
#assert.eq(
  type(multiple), dictionary, message: "Must be dictionary: " + repr(multiple)
)
#assert.eq(
  type(single), dictionary, message: "Must be dictionary: "
)

// Set files as Fluent databases
#transl(data: multiple)
#transl(data: single)