```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI two-way binding to value inside ObservableObject inside enum case (by Bogdan)

A: Here is a possible solution for such scenario, which even allows to remove AnyView. Tested with Xcode 11.4 / iOS 13.4

Provided full testable module, just in case.

```
// just for test
struct Parent_Previews: PreviewProvider {
    static var previews: some View {
        Parent(myCustomEnum: .option1(ObservableType1()))
    }
}

// no changes
class ObservableType1: ObservableObject {
    @Published var isChecked: Bool = false
}

// no changes
enum CustomEnum {
    case option1(ObservableType1)
}

struct Parent: View {
    var myCustomEnum: CustomEnum

    var body: some View {
        self.processCases() // function to make switch work
    }

	@ViewBuilder
    private func processCases() -> some View {
        switch myCustomEnum {
        case .option1(let type1Value):
            ObservedHolder(value: type1Value) { object in
                Child(isChecked: object.isChecked)
            }
    }
}

// just remove AnyView
struct Child: View {
    @Binding var isChecked: Bool
    var body: some View {
        Image(systemName: isChecked ? "checkmark.square" : "square")
            .onTapGesture {
                self.isChecked = !self.isChecked
            }
    }
}
```

Here is a playmaker

```
struct ObservedHolder<T: ObservableObject, Content: View>: View {
    @ObservedObject var value: T
    var content: (ObservedObject<T>.Wrapper) -> Content

    var body: some View {
        content(_value.projectedValue)
    }
}
```
