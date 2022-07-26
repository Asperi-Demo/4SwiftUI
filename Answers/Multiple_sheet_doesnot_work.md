```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Multiple sheet(isPresented:) doesn't work in SwiftUI (by )

A: It can be only one `sheet` modifier in view hierarchy, but inside one view body it is possible
to attach `sheet` modifier to different views. 

The case in question can be solved by the following (tested with Xcode 11.2)

    var body: some View {
    
        NavigationView {
            VStack(spacing: 20) {
                Button("First modal view") {
                    self.firstIsPresented.toggle()
                }
                .sheet(isPresented: $firstIsPresented) {
                        Text("First modal view")
                }
                Button ("Second modal view") {
                    self.secondIsPresented.toggle()
                }
                .sheet(isPresented: $secondIsPresented) {
                        Text("Only the second modal view works!")
                }
            }
            .navigationBarTitle(Text("Multiple modal view problem"), displayMode: .inline)
        }
    }

