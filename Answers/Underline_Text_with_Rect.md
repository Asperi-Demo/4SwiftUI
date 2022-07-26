```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to get Text width with SwiftUI? (by )

A: Just specify that container has fixed size and it will tight to content, like

![IBH4R](https://user-images.githubusercontent.com/62171579/163673886-20fbd17c-3ce7-446b-8964-e279efe2b889.png)

    var body: some View {
        VStack {
            Text("Statistics")
            Rectangle()
            .foregroundColor(.red)
            .frame(height: (5.0))
        }.fixedSize()              // << here !!
    }


