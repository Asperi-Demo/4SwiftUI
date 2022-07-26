```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to change the size and position of popover's page in swiftUI? (by Mihcael Smith)

A: Here is kind of correct configuration

![agIfJ](https://user-images.githubusercontent.com/62171579/170284078-2c32e790-afed-4999-8578-f8f5ce271d6e.png)

```
struct ContentView: View {
    @State private var isPop = false
    @State private var text = ""

    var body: some View {
        VStack{
            Button("Pop") { self.isPop.toggle() }
                .popover(isPresented: $isPop,
                         attachmentAnchor: .point(.bottom),   // here !
                         arrowEdge: .bottom) {                // here !!
                    VStack { // just example
                        Text("Test").padding(.top)
                        TextField("Placeholder", text: self.$text)
                            .padding(.horizontal)
                            .padding(.bottom)
                            .frame(width: 200)
                    }
            }
        }

    }
}
```

The `attachmentAnchor` is in UnitPoint, ie in 0..1 range with predefined constants, and `arrowEdge` is just Edge, to which popover arrow is directed. And size of popover is defined by internal content, by default it tights to minimal, but using standard .padding/.frame modifiers it can be extended to whatever needed.
