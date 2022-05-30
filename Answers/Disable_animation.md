```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: fullScreenCover with no animation? (by zumzum)

A: A possible solution is to disable views animation completely (and then, if needed, enable again in `.onAppear` of presenting content), like

        Button(action: {
            UIView.setAnimationsEnabled(false)    // << here !!
            showModal.toggle()
        }) {

and then

        }, content: {
            VStack {
                Text("Here I am")
                TheFullCover()
            }
            .onAppear {
                UIView.setAnimationsEnabled(true)    // << here !!
            }
        })

Tested with Xcode 13 / iOS 15
