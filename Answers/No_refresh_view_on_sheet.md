```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: prevent View from refreshing when presenting a sheet (by Dmytro Pashkov)

A: When `sheet` presentation is activated the body of view is rebuilt, so it needs to make separated 
condition-independent part of view body to achieve behavior as you wish, like below

    struct RandomView: View {  
        var body: some View {
            Text("Random text: \(Int.random(in: 0...100))")
        }
    }
    
    struct ContentView: View {
    
        @State var active = false
    
        var body: some View {
            VStack {
                RandomView() // instantiated by not updated (body is not called)
    
                Button(action: { self.active.toggle() }) {
                    Text("Show pop up")
                }
            }
            .sheet(isPresented: $active) {
                Text("POP UP")
            }
        }
    }

In this case `RandomView` is not rebuilt because is not dependent on `active` state.
