```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - present sheet programatically (by squarehippo10)

A: Here is demo of possible approach - you activate second sheet in `onDismiss` of first one. Tested with Xcode 12 / iOS 14.

```
struct DemoTwoSheets: View {
    @State private var firstSheet = false
    @State private var secondSheet = false
    var body: some View {
        VStack {
            Button("Tap") { self.firstSheet = true }
                .sheet(isPresented: $firstSheet, onDismiss: {
                    self.secondSheet = true
                }) {
                    Text("First sheet")
                }
            EmptyView()
                .sheet(isPresented: $secondSheet) {
                    Text("Second sheet")
                }
        }
    }
}
```

**Update:**

Here is an alternate which works for SwiftUI 1.0 as well. Tested with Xcode 11.4 / iOS 13.4 and Xcode 12b5 / iOS 14.

```
struct DemoTwoSheets: View {
    @State private var firstSheet = false
    @State private var secondSheet = false
    var body: some View {
        VStack {
            Button("Tap") { self.firstSheet = true }
                .sheet(isPresented: $firstSheet, onDismiss: {
                    self.secondSheet = true
                }) {
                    Text("First sheet")
                }
                .background(Color.clear
                    .sheet(isPresented: $secondSheet) {
                        Text("Second sheet")
                    })
        }
    }
}
```
