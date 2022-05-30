```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to display an image where the user taps? SwiftUI (by I Kaya)

A: It just need to read location of tap and use it as position for hammer image, like below - all by SwiftUI

Tested with Xcode 11.4 / iOS 13.4

![rb9W5](https://user-images.githubusercontent.com/62171579/170923260-b2093c6a-d5ac-4285-90d7-1c435af82a60.gif)

Here is modified only part


    @State private var location = CGPoint.zero      // < here !!
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack {
                Image("mine1").resizable().frame(width: UIScreen.main.bounds.height * 1.4, height: UIScreen.main.bounds.height)
                    .gesture(DragGesture(minimumDistance: 0).onEnded { value in
                        self.location = value.location // < here !!
                        self.mine()
                    })
                if self.showingMinedHammer {
                    Image(systemName: "hammer.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .position(self.location)    // < here !!
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
