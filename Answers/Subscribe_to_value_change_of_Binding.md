```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI/Combine: subscribe to value change of @Binding (by )

A: Here is possible approach. Tested with Xcode 11.4 / iOS 13.4 (SwiftUI 1.0+)

*Update for SwiftUI 2.0+:* you can use `.onChange(of: counter)` instead (which is actually built-in 
replacement for above), however the difference in behavior that it does not generate event for
initial value (which `Just` does), but only for actual changes.

```
struct Greeter: View {
    @Binding var counter: Int

    var body: some View {
        Text("Hello, world #\(counter)!")
            .padding()
            .onReceive(Just(counter)) {    // << subscribe
                print(">> greeter: \($0)") // << use !!
            }
    }
}
```
