#import "/src/lib.typ": transl
#set page(height: auto, width: 10cm, margin: 1em)

#transl(data: yaml("/docs/example/lang/std.yaml"))
#transl(data: yaml("/docs/example/lang/ftl.yaml"))

#set text(lang: "es")


#show: transl.with("passionate", "passion")

You are passionate because you live with so much passion!

#line()

// Show rule pattern from data.std.en.much
// Translation from data.ftl.it.much
#show: transl.with("much", from: "en", to: "it")

I LOVE YOU SO MUCH!

I love you so much!

i love you so much!
