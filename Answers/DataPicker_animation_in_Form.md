```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Fix odd DatePicker animation behaviour in SwiftUI form (by Sam)

A: Here are two possible workarounds for iOS <14: 1) simple one is to disable animation 
at all, and 2) complex one is to mitigate incorrect animation by injecting custom animatable modifier

Tested both with Xcode 11.4 / iOS 13.4

**1) simple solution** - wrap `DatePicker` into container and set animation to nil

![ymqE8](https://user-images.githubusercontent.com/62171579/169119798-50904e42-bf26-4d3d-b3d0-29c0f54866e6.gif)

```
VStack {
    DatePicker("Test", selection:$date).id(2)
}.animation(nil)
```

**2) complex solution** - grab `DatePicker` changing frame using a) view preference 
reader [ViewHeightKey](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/Automatically_adjustable_view_height.md) and 
b) animate this frame explicitly using [AnimatingCellHeight](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/Animating_List_row_height.md) from my other solutions.

![PSZzG](https://user-images.githubusercontent.com/62171579/169119885-036f6a1a-deb8-497a-821b-accf5a8b3038.gif)

```
struct TestDatePickersInForm: View {
    @State var date = Date()
    @State var isDateShown = false
    @State private var height = CGFloat.zero
    var body: some View {
            Form {
                Section(header: Text("Title")) {
                    // demo of complex solution
                    VStack {
                        DatePicker("Test", selection:$date).id(1)
                            .background(GeometryReader {
                                Color.clear.preference(key: ViewHeightKey.self,
                                    value: $0.frame(in: .local).size.height) })
                    }
                    .onPreferenceChange(ViewHeightKey.self) { self.height = $0 }
                    .modifier(AnimatingCellHeight(height: height))
                    .animation(.default)

                    // demo of simple solution
                    VStack {
                        DatePicker("Test", selection:$date).id(2)
                    }.animation(nil)

                    Text("Pick a date").onTapGesture {
                        withAnimation {
                            self.isDateShown.toggle()
                        }

                    }
                    if(isDateShown) {
                        DatePicker("", selection: $date).datePickerStyle(WheelDatePickerStyle()).labelsHidden().id(3)
                    }

                }
                Section(header: Text("hello")) {
                    Text("test")
                }
        }

    }
}
```
