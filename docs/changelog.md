# 0.0.0


## 0.1.0

- Simple YAML/dictionary-based database
- Fluent support
- Translation of words and expressions
- Translation through `show` rule
- Regular expression patterns
- Contextualized strings (workaround for `context()`)
- Context-free strings


### 0.1.1

- Fixed: `#transl(data, mode: str)` used to return `content` because of a state update
  - `#transl(data)` state update not done anymore when `#transl(mode: str)`
- Updated: Fluent arguments `#transl(args: (foo: bar))` &rarr; `#transl(foo: bar)`