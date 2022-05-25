```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: What is the role of tag in SwiftUI? (by lgm0905)

A: SwiftUI `Picker` detects selection either by `tag` or by `id`, for this types of selection and `tag` (or `id`) must be the same.

Here is a demo (tested with Xcode 12 / iOS 14)

```
struct InitGender: View {
    @State private var selection: String = "M"
    let genderRange = ["M","F"]

    var body: some View {
        VStack {
            Text("Select your gender")
                .font(.title)
                .bold()
            Text("Selected: \(selection)")

            Picker("Select gender", selection : $selection) {
                ForEach(0..<genderRange.count) {
                    Text(self.genderRange[$0]).tag(self.genderRange[$0])
                }
            }
            .labelsHidden()
            .clipped()
       }
   }
}
```

alternate working variant of `Picker`

    Picker("Select gender", selection : $selection) {
        ForEach(genderRange, id: \.self) {
            Text($0)
        }
    }

