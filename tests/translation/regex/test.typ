#import "/src/lib.typ": transl
#set page(height: auto)
#transl(data: yaml("/docs/example/langs.yaml"))

#set text(lang: "it")
// Pattern to match "we'll share"
#transl("we.*?re")

#show: doc => transl("i.+my.+!", doc)

I love you, my dear!

I kinda like you as more than my friend!

I hate you, my enemy!