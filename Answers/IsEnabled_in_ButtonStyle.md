>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Is there a way to get isDisabled state from ButtonStyle in SwiftUI? (by Zorayr)

A: You can use `isEnabled` environment value, but it does not work directly in button style, you need some sub-view. Here is a demo of possible approach (all your additional parameters you can inject via constructor)

Tested with Xcode 12 / iOS 14.

```
struct CellButtonStyle: ButtonStyle {
  
  struct CellBackground: View {
    @Environment(\.isEnabled) var isEnabled       // << here !!
    var body: some View {
      Rectangle().fill(isEnabled ? Color.black : Color.yellow)
    }
  }
  
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding(7)
        .background(CellBackground())     // << here !!
    }
}
``` 
