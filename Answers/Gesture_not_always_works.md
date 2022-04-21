```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Why doesn't SwiftUI onTapGesture always work (by Jmcg)

A: In this case Rectangle has foreground color as .clear, so it is transparent. Many 
default/built-in views in SwiftUI are transparent by default as well. By  
gestures require content to be opaque to be hit-testable.

The solution is to use `.contentShape` modifier that makes hit-testable entire frame 
independently of transparency.

Here is a fix (tested with Xcode 11.4 / iOS 13.4)

    Rectangle()
        .foregroundColor(self.cellFg[row][column])   // .clear color is here !!
        .border(Color.gray, width: 1)
        .contentShape(Rectangle())         // << fix !!
