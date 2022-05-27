```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Why does an animation in a NavigationView starts from the top left corner? (by DanielZanchi)

A: > Why does an animation in a NavigationView starts from the top left corner?

Because implicit animation affects all animatable properties, including position, which on creation time is `CGPoint.zero` (ie. top-left corner).

Such cases are solved by linking animation to dependent state value, thus it activates only when state changed, so all animatable properties not affected.

Here is possible variant for your case. Tested with Xcode 12.1 / iOS 14.1.

```
struct ContentView: View {
    
    @State var show = false
    
    var body: some View {
    GeometryReader { gp in
      NavigationView {
          HStack {
             Text("Hello, world!")
                .padding()
                .background(Color.blue)
                .offset(x: 0, y: show ? 0 : -gp.size.height / 2)
                .animation(Animation.easeOut.delay(0.6), value: show)
                .onAppear {
                     self.show = true
                }
                .navigationTitle("Why?")
          }
      }
    }
    }
}
```
