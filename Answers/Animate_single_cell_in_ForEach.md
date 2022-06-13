```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to animate particular button from ForEach in SwiftUI? (by Michał Śniady)

A: Here is possible alternate approach - more appropriate looks to move button into separated view and let it animate itself when needed.

Demo prepared on some replicated simplified code (due to absent parts in provided snapshot). Tested with Xcode 12 / iOS 14.

![XlPGq](https://user-images.githubusercontent.com/62171579/173292241-290b6d7b-2321-42b4-9251-c488f58917b7.gif)

```
struct DemoView: View {
    let countries = ["flag-1", "flag-2", "flag-3", "flag-4"]

    @State private var number: Int = -1
    let correctAnswer = 1
    var body: some View {
        VStack {
            ForEach(0 ..< 3) { number in
                FlagButton(number: number, image: self.countries[number], answer: correctAnswer){
                    self.flagTapped(number)
                }
            }
        }
    }

    private func flagTapped(_ number: Int) {
        self.number = number
    }
}


struct FlagButton: View {
    let number: Int
    let image: String
    let answer: Int
    var showAnimation = false
    let action: () -> ()

    @State private var animationAmount = Double.zero
    var body: some View {
        Button(action: {
            if self.number == self.answer {
                self.animationAmount += 360
            }
            action()
        }) {
            Image(image)
        }
        .rotation3DEffect(.degrees(number == answer ? self.animationAmount : 0), axis: (x: 0, y: 1, z: 0))
        .opacity(self.showAnimation && number != answer ? 0.25 : 1)
        .background(self.showAnimation && number != answer ? Color.red: nil)
        .animation(.default)
    }
}
```
