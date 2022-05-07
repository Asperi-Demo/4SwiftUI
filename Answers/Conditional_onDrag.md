```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI disable drag function (by user1151874)

A: Here is a solution with helper modifier. Tested with Xcode 11.4.

```
// @available(iOS 13.4, *) - needed for iOS
struct Draggable: ViewModifier {
    let condition: Bool
    let data: () -> NSItemProvider

    @ViewBuilder
    func body(content: Content) -> some View {
        if condition {
            content.onDrag(data)
        } else {
            content
        }
    }
}

// @available(iOS 13.4, *) - needed for iOS
extension View {
    public func drag(if condition: Bool, data: @escaping () -> NSItemProvider) -> some View {
        self.modifier(Draggable(condition: condition, data: data))
    }
}
```

and updated your code would be

```
ForEach(animals, id: \.id)
{
    animal in
    Button(action:{})
    {
        Text(animal.name)
    }
    .disabled(!animal.isEnable)
    .drag(if: animal.isEnable) {     // << here !!
        let provider = NSItemProvider(object: animal.name as NSString )
        provider.suggestedName = animal.name
        return provider
    }
}
```
