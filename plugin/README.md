# Rust Typst Plugin
```typst
#let wasm = plugin("plugin.wasm")

#cbor(
  wasm.get_message(
    cbor.encode((
      source: read("db.yaml"),
      msg-id: "identifier",
      args: (foo: 1, bar: 2),
      lang: "pt-BR",
    ))
  )
)
```

This is a Typst plugin written in Rust and compiled to WebAssembly.
It allows `#transl` to interpret and retrieve [Fluent](https://projectfluent.org/) data.

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