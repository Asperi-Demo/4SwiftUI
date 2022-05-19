```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How do I trigger updateUIView of a UIViewRepresentable? (by Marco Carandente)

A: You need to create UIKit view inside `makeUIView` and via Binding pass only dependent data. That binding change, when related state - source of truth - changed, calls `updateUIView`, where you should update your UIKit view.

Here is simplified demo sketch only, to show concept (might have typos):

```
struct SpritzUIViewRepresentable : UIViewRepresentable{
    @Binding var currentWord: SpritzSwiftWord
    @Binding var backgroundColor: UIColor
    
    func makeUIView(context: Context) -> SpritzSwiftView {
        // create and configure view here
        return SpritzSwiftView(frame: CGRect.zero) // frame does not matter here
    }

    func updateUIView(_ uiView: SpritzSwiftView, context: Context) {
       // update view properties here from bound external data
       uiView.backgroundColor = backgroundColor
       uiView.updateWord(currentWord)
    }
}
```

and button now should just change model data

        VStack {
            Text("SpritzTest")
                .padding()
            SpritzUIViewRepresentable(backgroundColor: $backgroundColor, SpritzViewManager:$ssManager, currentWord: $currentWord)
               .padding()
            Button(action:
                {
                    ssManager  = SpritzSwiftManager(withText: "Text try one two three", andWordPerMinute: 200)

                    self.backgroundColor = .clear
                    ssManager.startReading { (word, finished) in
                        if !finished {
                            self.currentWord = word
                        }
                    }
                })
            {
               Text("Start")
            }


assuming updated properties

```
@State private var currentWord = SpritzSwiftWord(word: "")
@State private var backgroundColor = UIColor.white         // whatever you want
```
