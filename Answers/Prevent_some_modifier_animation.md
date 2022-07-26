```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: iOS SwiftUI: prevent resizable() animation (by Andrea Miotto)

A: Use `.animation(nil)` right after property/ies which animations you want to disable, like below

    var body: some  View {
        GeometryReader { proxy in
            Image(uiImage: self.model.image)
                .resizable()
                .animation(nil)           // << disables animation
                .transition(.opacity)
                .animation(.default)      // << enables animation
                .scaledToFill()
                .frame(width: proxy.size.width, height: proxy.size.width)
                .aspectRatio(1/1, contentMode: .fit)
                .clipped()
        }
    }
