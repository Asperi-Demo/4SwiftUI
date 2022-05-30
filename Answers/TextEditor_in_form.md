```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to get the TextEditor to display multiple lines? (by gurehbgui)

A: This is how Form works. The possible (simple) solution is to give `TextEditor` a frame

![Cavzb](https://user-images.githubusercontent.com/62171579/170915334-b498ff1d-3b6c-4f3f-a9f2-6a1ff4b99648.png)


    TextEditor(text: $text)
        .frame(height: 80)

**Update:** more complicated case (dynamic calculation based on reference text, and taking into account dynamic font size)

Default

![iuBa3](https://user-images.githubusercontent.com/62171579/170915364-8d46d2a3-8bca-43d8-85d8-76a8e3c14fb2.png)

Large font settings

![iFpSv](https://user-images.githubusercontent.com/62171579/170915392-bcfd5623-5316-4e55-8579-fa02a0247293.png)

```
let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."

struct ContentView: View {
    @State var value: String = lorem
    @State var text: String = lorem

    @State private var textHeight = CGFloat.zero
    var body: some View {
        Form {
            TextField("Title", text: $value)
            TextEditor(text: $text)
                .frame(minHeight: textHeight)
        }
        .background(
            Text("0\n0\n0")  // any stub 3 line text for reference
                .padding(.vertical, 6)  // TextEditor has default inset
                .foregroundColor(.clear)
                .lineLimit(3)
                .background(GeometryReader {
                    Color.clear
                        .preference(key: ViewHeightKey.self, value: $0.frame(in: .local).size.height)
                })
        )
        .onPreferenceChange(ViewHeightKey.self) { self.textHeight = $0 }
    }
}
```

The `ViewHeightKey` preference is taken from [this my answer](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/Automatically_adjustable_view_height.md)

*Note: in-code fonts for reference Text and TextEditor should be used the same*
