```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How we can make custom Step for ForEach SwiftUI?

A: Here is possible approach

    List {
        ForEach(Array(stride(from: 0, to: 21, by: 5)), id: \.self) { index in // (Step == 5) not 1
            Text("Hello, world!")
                .padding()
        }
    }

