# Translator

<center>
  Easy and simple translations for words and expressions, with support for localization
</center>


## Quick Start

```typ
#import "@preview/transl:0.1.0": transl
#transl(data: yaml("lang.yaml"))

// Get "I love you" in Spanish:
#set text(lang: "es")
#transl("I love you")

// Translate every "love" to Italian:
#set text(lang: "it")
#show: doc => transl("love", doc)
```

## Description

Get comprehensive and contextual translations, with support for regular
expressions and [Fluent](https://projectfluent.org/) localization. This package
have one main command, `#transl`, that receives one or more expression strings,
searches for each of them in its database and then returns the translation for
each one.

The expressions are the text to be translated, they can be simple words or longer
text excerpts, or can be also used as identifiers to obtain longer text blocks at
once. Regular expression patterns are supported when _transl_ is used in `#show`
rules.


## More Information

- [Official manual](https://raw.githubusercontent.com/mayconfmelo/transl/refs/tags/1.1.0/docs/manual.pdf)
- [Example PDF result](https://raw.githubusercontent.com/mayconfmelo/transl/refs/tags/1.1.0/docs/example.pdf)
- [Example Typst code](https://github.com/mayconfmelo/transl/blob/1.1.0/template/main.typ)
- [Changelog](https://github.com/mayconfmelo/transl/blob/main/changelog.md)
- [Development setup](https://github.com/mayconfmelo/transl/blob/main/docs/setup.md)


> [!NOTE]
> The Fluent support is a fork of a [linguify](https://github.com/typst-community/linguify/)
> feature, and all the overall project concept is heavily inspired in this great package.