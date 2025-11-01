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

- Fixed: `#transl(data, mode: str)` used to return `content` because of a state update
  - `#transl(data)` state update not done anymore when `#transl(mode: str)`
- Updated: Fluent arguments `#transl(args: (foo: bar))` &rarr; `#transl(foo: bar)`


## 0.2.0

- Internal re-design
- Removed: `#fluent` command
- Removed: `#std` command
- Added: Fluent YAML database
- Added: `{$arg}` placeables in standard database
- Added: `#transl(expression)` can be regular expression strings
- Added: Fallback system for database searches (std, regex in std, ftl)
- Added: Trick to use Fluent database in `#show` rules
  - Rule pattern from standard database
  - Translation string from Fluent database