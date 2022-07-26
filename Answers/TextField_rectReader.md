```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Make TextField wrap it content in SwiftUI (by Konstantin.Efimenko)

A: Here is possible approach with dynamically sized `TextField`.

*Note: helper `rectReader` is taken from [this](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/Get_CGRect_view.md) my solution.*

Tested with Xcode 11.4 / iOS 13.4 (black border is only for demo)

![gpBmw](https://user-images.githubusercontent.com/62171579/170859725-5f117f8a-3278-4d57-a168-2e6c9f65e734.gif)

```
struct DemoCenterTextField: View {
    @State private var value = ""
    @State private var frame = CGRect.zero

    var body: some View {
        return HStack(alignment: .bottom) {
            ZStack {
                Text(self.value).foregroundColor(Color.clear)
                    .fixedSize()
                    .background(rectReader($frame))

                TextField("#.#", text: $value)
                    .multilineTextAlignment(.trailing)
                    .frame(minWidth: 80, idealWidth: frame.width)
                    .fixedSize(horizontal: true, vertical: false)
                    .border(Color.black)      // << for demo only

            }.font(Font.system(size: 40).bold())

            Text("PLN")
        }
    }
}
```
