# Rust Typst Plugin
```typst
#let wasm = plugin("plugin.wasm")

#cbor(
  wasm.get_message(
    cbor.encode((
      source: read("database.ftl"),
      msg-id: "identifier",
      args: (foo: 1, bar: 2),
      lang: "pt-BR",
    ))
  )
)
```

A Typst plugin written in Rust and compiled to WebAssembly that
allows `#transl` to interpret and retrieve [Fluent](https://projectfluent.org/) data.

This plugin was forked from [linguify](https://github.com/typst-community/linguify/tree/main/linguify_fluent_rs) project.


## Build

Using `just` from inside _transl_ project:
```bash
just plugin
```

Or manually:
```bash
rustup target add wasm32-unknown-unknown
cargo build --release --target wasm32-unknown-unknown
cp target/wasm32-unknown-unknown/release/plugin.wasm .
```