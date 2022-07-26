```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI ZStack: Align some descendants to bottom, and some to top (by Tomáš Kafka)

A: Here is possible approach

    ZStack {

     // content here

    }
    .overlay(YourTopView(), alignment: .top)
    .overlay(YourBottomView(), alignment: .bottom)

Other possible variant is to use one `.overlay` with `VStack` having two views and `Spacer` in between.
