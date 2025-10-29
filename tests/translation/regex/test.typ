#import "/src/lib.typ": transl
#set page(width: auto, height: auto, margin: 1em)
#transl(data: yaml("/docs/example/lang/std.yaml"))

#set text(lang: "pt")
#transl("l.{2}e") // love


#show: doc => transl("i .{4}.*my.dear", doc) // i love you, my dear

I love you, my dear! I always loved you!