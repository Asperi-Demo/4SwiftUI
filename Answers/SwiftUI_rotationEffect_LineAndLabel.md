```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI's rotationEffect modifier has different behavior going clockwise versus counter-clockwise (by Bill Nattaner)

A: By default any Shape consumes all available space, but in your case
it is clear that you want to have it aligned with text only, so a possible solution
is to fix size for common container vertically

Here is a demo.

![ezgif com-gif-maker-36](https://user-images.githubusercontent.com/62171579/162677889-1494f347-f250-427e-8e7d-2e7184d67caf.gif)

Tested with Xcode 13.3 / iOS 15.4

    var body: some View {
        HStack {
            SimpleLine().stroke()
            Text("A Label")
        }
        .fixedSize(horizontal: false, vertical: true)  // << here !!
    }


[Test module here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestRotatingLineAndLabel.swift)
