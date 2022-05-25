```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: Resize text to fit button (by Rob Paterson)

A: As far as I understood your goal the following should give you required effect (or sort of)... 

Tested with Xcode 11.4 / iOS 13.4

![SzBMK](https://user-images.githubusercontent.com/62171579/170253700-ae5eca24-cca8-47b5-b834-dfb80c8e3bcc.png)


```swift
configuration.label
    .padding(.horizontal, 8).lineLimit(1).minimumScaleFactor(0.4) // << this place !
    .foregroundColor(Color.white)
```
