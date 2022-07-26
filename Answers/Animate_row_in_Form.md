```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Dynamic row height in a SwiftUI form (by rustproofFish)

A: Here is possible solution with fluent row height change (using `AnimatingCellHeight` modifier 
taken from my solution in [SwiftUI - Animations triggered inside a View that's in a list doesn't animate the list as well](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/Animating_List_row_height.md) ).

Tested with Xcode 11.4 / iOS 13.4

![DnuXS](https://user-images.githubusercontent.com/62171579/169203360-25c964ae-d0d5-4026-a617-decd614b99d4.gif)


```
struct MyView: View {
    @State var isDisclosed = false

    var body: some View {
        Form {
            Spacer()

            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                    .zIndex(1)
                    .onTapGesture { withAnimation { self.isDisclosed.toggle() } }

                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 100, height: 100)
                }.frame(maxHeight: .infinity, alignment: .bottom)
            }
            .modifier(AnimatingCellHeight(height: isDisclosed ? 150 : 100))

            Spacer()
        }
    }
}
```
