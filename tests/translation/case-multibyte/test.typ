#import "/src/lib.typ": transl
#set page(height: auto, width: auto, margin: 1em)

// Test for case adjustment when the translated value starts with a multi-byte
// UTF-8 character.
#transl(data: (
  l10n: "std",
  es: (
    contents: "índice",
    summary: "épilogo",
    appendix: "ñame",
  ),
))

#set text(lang: "es")

Lower: #transl("contents")  // índice
Sentence: #transl("Contents") // Índice
Upper: #transl("CONTENTS") // ÍNDICE

Lower: #transl("summary") // épilogo
Sentence: #transl("Summary") // Épilogo
Upper: #transl("SUMMARY") // ÉPILOGO

Lower: #transl("appendix") // ñame
Sentence: #transl("Appendix") // Ñame
Upper: #transl("APPENDIX") // ÑAME
