```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI how to have next and back animations? (by Markon)

A: We need to reverse transition when navigating back.

Here is possible approach (also made transition in one place and corrected animation to work everywhere, including Preview). 

Tested with Xcode 12 / iOS 14.

![Ubcjj](https://user-images.githubusercontent.com/62171579/171552850-556941aa-7133-422e-9858-9ea3913fcfa8.gif)

```
struct ContentView: View {
    @State var page: Int = 0

    @State private var isBack = false   // << reverse flag (not animatable)
    var body: some View {

        VStack {
            HStack {
                Button(action: {
                    self.isBack = true
                    self.page = self.page - 1
                }) {
                    Text("Back")
                }

                Spacer()

                Button(action: {
                    self.isBack = false
                    self.page = self.page + 1
                }) {
                    Text("Next")
                }
            }
            Spacer()

            Group {
                if page == 0 {
                    PageView(name: "First page", color: .brown)
                } else if page == 1 {
                    PageView(name: "Second page", color: .systemGreen)
                } else if page == 2 {
                    PageView(name: "Third page", color: .systemBlue)
                }
            }.transition(AnyTransition.asymmetric(
                insertion:.move(edge: isBack ? .leading : .trailing),
                removal: .move(edge: isBack ? .trailing : .leading))
            )
            .animation(.default, value: self.page)   // << animate here by value
        }
    }
}

struct PageView: View {
    var name: String
    var color: UIColor
    var body: some View {
        HStack {
            Spacer()
            Text(name)
            Spacer()
        }
        .padding()
        .padding(.vertical, 50)
        .background(Color(color))
    }
}
```
