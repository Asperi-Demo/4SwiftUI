```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to make SwiftUI Picker Wrap Text (by Stoic)

A: A solution appears a bit complicated because Picker is not native SwiftUI control, but has `UIPickerView` at backend, 
so we need combination of already mentioned one [to get rid of compression contains](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestMultiPickersInRow.swift) and 
another one [to calculate most long label](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/Align_views_inside_Picker.md) and compress picker explicitly.

![ezgif com-gif-maker-72](https://user-images.githubusercontent.com/62171579/179418028-7483cbcd-212d-47b4-9603-0ea5fa5e3fa6.gif)

Main part is

    @State private var maxWidth = CGFloat.zero
	@State private var width = CGFloat.infinity

    var body: some View {
        Picker("", selection: $selection) {
            ForEach( ... 

               // Row/Label view is here

                .background(GeometryReader {
                    Color.clear.preference(key: ViewWidthKey.self,
                        value: $0.frame(in: .local).size.width)
                })
                .onPreferenceChange(ViewWidthKey.self) {
                    self.maxWidth = max($0, maxWidth)
                	width = max($0, maxWidth)
                }
            }
        }
        .pickerStyle(.wheel)
        .frame(maxWidth: width + 2 * 20 /* padding on both sides */)
    }

Tested with Xcode 13.4 / iOS 15.5

