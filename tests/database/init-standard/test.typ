#import "/src/lib.typ": transl

// Import standard translation file
#let database = yaml("/docs/example/langs.yaml")

#assert.eq(
  type(database), dictionary, message: "Must be dictionary: " + repr(database)
)

// Set translation file as standard database
#transl(data: database)

