# Translator

<div align="center">

<p class="hidden">
Easy and simple translations with support for localization
</p>

<p class="hidden">
  <a href="https://typst.app/universe/package/transl">
    <img src="https://img.shields.io/badge/dynamic/xml?url=https%3A%2F%2Ftypst.app%2Funiverse%2Fpackage%2Ftransl&query=%2Fhtml%2Fbody%2Fdiv%2Fmain%2Fdiv%5B2%5D%2Faside%2Fsection%5B2%5D%2Fdl%2Fdd%5B3%5D&logo=typst&label=Universe&color=%23239DAE&labelColor=%23353c44" /></a>
  <a href="https://github.com/mayconfmelo/transl/tree/dev/">
    <img src="https://img.shields.io/badge/dynamic/toml?url=https%3A%2F%2Fraw.githubusercontent.com%2Fmayconfmelo%2Ftransl%2Frefs%2Fheads%2Fdev%2Ftypst.toml&query=%24.package.version&logo=github&label=Development&logoColor=%2397978e&color=%23239DAE&labelColor=%23353c44" /></a>
</p>

[![Manual](https://img.shields.io/badge/Manual-%23353c44)](https://raw.githubusercontent.com/mayconfmelo/transl/refs/tags/0.2.0/docs/manual.pdf)
[![Example PDF](https://img.shields.io/badge/Example-PDF-%23777?labelColor=%23353c44)](https://raw.githubusercontent.com/mayconfmelo/transl/refs/tags/0.2.0/docs/example.pdf)
[![Example SRC](https://img.shields.io/badge/Example-SRC-%23777?labelColor=%23353c44)](https://github.com/mayconfmelo/transl/blob/0.2.0/docs/example/main.typ)
[![Changelog](https://img.shields.io/badge/Changelog-%23353c44)](https://github.com/mayconfmelo/transl/blob/main/docs/changelog.md)
[![Contribute](https://img.shields.io/badge/Contribute-%23353c44)](https://github.com/mayconfmelo/transl/blob/main/docs/contributing.md)

<p class="hidden">

[![Tests](https://github.com/mayconfmelo/transl/actions/workflows/tests.yml/badge.svg)](https://github.com/mayconfmelo/transl/actions/workflows/tests.yml)
[![Build](https://github.com/mayconfmelo/transl/actions/workflows/build.yml/badge.svg)](https://github.com/mayconfmelo/transl/actions/workflows/build.yml)
[![Spellcheck](https://github.com/mayconfmelo/transl/actions/workflows/spellcheck.yml/badge.svg)](https://github.com/mayconfmelo/transl/actions/workflows/spellcheck.yml)

</p>
</div>


## Quick Start

```typ
#import "@preview/transl:0.2.0": transl
#set text(lang: "es")

#transl(data: yaml("lang.yaml"))

#transl("I love you")

#show: transl.with("love")
```


## Description

Get comprehensive and localized translations, with support for regular
expressions and [Fluent](https://projectfluent.org/) files. This package
comes with only one `#transl` command used to both set the translation database
and retrieve translations. 

The expressions are the texts to be translated; they can be words, phrases, or
regular expression strings. Multiple expressions can be used in a single command,
where each one will be retrieved and concatenated (separated by space).


## Feature List

- Automatic translation to `#text.lang` language
- Robust translation database
  - Standard (simple dictionary)
  - Fluent files
- Support for `#show` rules
- Regular expressions
- Multiple ways to obtain values
  - Retrieve opaque `context()` values
  - Retrieve context-dependent strings
  - Retrieve plain strings
- Localization arguments
  - Standard databases (basic)
  - Fluent databases


---------------

Although written from scratch, the package's conceptual structure is heavily
inpired by the [linguify](https://www.typst.app/universe/package/linguify)
package; the Fluent WASM plugin was also borrowed from this great package.