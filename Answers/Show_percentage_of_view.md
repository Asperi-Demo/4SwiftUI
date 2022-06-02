```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Swiftui - only show a percentage of a view (by Hoopes)

A: If I correctly understood your concern, here is a solution. Tested with Xcode 11.4 / iOS 13.4.

![rcBsb](https://user-images.githubusercontent.com/62171579/171704086-1a47119c-39f8-4daa-9553-43d17c26d126.gif)

    ZStack {
        ZStack(alignment: .leading) {
    
            // The main rectangle
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .frame(width: geom.size.width,
                       height: 200)
    
            // The progress indicator...
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red)
                .opacity(0.5)
                .frame(width: CGFloat(self.value) * geom.size.width,
                       height: 200)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))    // << here !!

