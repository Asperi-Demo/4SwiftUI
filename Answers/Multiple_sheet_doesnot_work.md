```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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

