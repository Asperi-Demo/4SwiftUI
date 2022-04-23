```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - Detect when ScrollView has finished scrolling? (by Mofawaw)

A: Here is a demo of possible approach - use publisher with changed scrolled content coordinates with debounce, so event reported only after coordinates stopped changing.

Tested with Xcode 12.1 / iOS 14.1

UPDATE: verified as worked with Xcode 13.3 / iOS 15.4

*Note: you can play with debounce period to tune it for your needs.*

![UQkA4](https://user-images.githubusercontent.com/62171579/163712294-a229e6cb-cd72-43de-8168-1bb73ccb2912.gif)


```
struct ContentView: View {
  let detector: CurrentValueSubject<CGFloat, Never>
  let publisher: AnyPublisher<CGFloat, Never>

  init() {
    let detector = CurrentValueSubject<CGFloat, Never>(0)
    self.publisher = detector
      .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
      .dropFirst()
      .eraseToAnyPublisher()
    self.detector = detector
  }
  
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0...100, id: \.self) { i in
                    Rectangle()
                        .frame(width: 200, height: 100)
                        .foregroundColor(.green)
                        .overlay(Text("\(i)"))
                }
            }
            .frame(maxWidth: .infinity)
            .background(GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self,
                    value: -$0.frame(in: .named("scroll")).origin.y)
            })
            .onPreferenceChange(ViewOffsetKey.self) { detector.send($0) }
        }
        .coordinateSpace(name: "scroll")
        .onReceive(publisher) {
          print("Stopped on: \($0)")
        }
    }
}
```

[Test module and dependent parts in project](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestScrollDidEndDetect.swift)
