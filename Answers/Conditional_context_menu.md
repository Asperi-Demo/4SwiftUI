```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How do I present a SwiftUI context menu conditionally? (by Jaanus)

A: Here is a demo for optional context menu usage (tested with Xcode 11.2 / iOS 13.2)

![xaJ4d](https://user-images.githubusercontent.com/62171579/178999258-c6d78fb6-faf9-4ca7-8b96-8ae89bbf2a8b.gif)

    struct TestConditionalContextMenu: View {
        @State private var hasContextMenu = false
        var body: some View {
            VStack {
                Button(hasContextMenu ? "Disable Menu" : "Enable Menu")
                    { self.hasContextMenu.toggle() }
                Divider()
                Text("Hello, World!")
                    .background(Color.yellow)
                    .contextMenu(self.hasContextMenu ?
                        ContextMenu {
                                Button("Do something1") {}
                                Button("Do something2") {}
                        } : nil)
            }
        }
    }
