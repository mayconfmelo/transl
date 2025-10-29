#import "/src/lib.typ": transl
#set page(height: auto, width: 10cm, margin: 1em)

#transl(data: yaml("/docs/example/lang/std.yaml"))
#transl(data: yaml("/docs/example/lang/ftl.yaml"))

#set text(lang: "es")


#show: transl.with("hot", "passionate", "passion")

In this text the words hot, passionate, and passion were automatically translated.


// Show rule pattern from data.std.en.much
// Translation from data.ftl.it.much
#show: transl.with("much", from: "en", to: "it")

I LOVE YOU SO MUCH!

I love you so much!

i love you so much!
