# 0.0.0


## 0.1.0

- Optional `#transl(from)` sets original text language
- Optional `#transl(to)` sets target translation language
- Automatic translation to `#text.lang` language
- Robust translation database
  - Standard (simple dictionary)
  - Fluent files
- Support for `#show` rules
- Regular expression patterns
- Multiple ways to obtain values
  - Retrieve `context()` values
  - Retrieve contextualized strings
  - Retrieve plain strings
- Localization through Fluent arguments


### 0.1.1

- Fixed: `#transl(data: database, mode: str)` returning `content` (database update not done anymore)
- Updated: Fluent arguments `#transl(args: (foo: bar))` &rarr; `#transl(foo: bar)`


## 0.2.0

- Internal re-design
- Removed: `#fluent` command
- Removed: `#std` command
- Added: Fluent YAML database
- Added: Support for `{$arg}` placeables in standard database values
- Added: `#transl(expression)` can be regular expression strings
- Added: Translation text case set by expression
- Added: Support for language regions (`xy-XY`)
- Added: Database fallback system
  1. Searches expression in standard database
  2. Searches expression as regex in standard database
  3. Searches expression as identifier in Fluent database
  4. Panics
- Added: Trick to use Fluent database in `#show` rules
  - Get show rule pattern from standard database
  - Get translation string from Fluent database


### 0.2.1

- Internal re-design of Fluent WASM plugin
- Fixed [#11](https://github.com/mayconfmelo/transl/issues/11): panic when obtained translated text starts with multi-byte character ("é", "í", "ñ", etc.)