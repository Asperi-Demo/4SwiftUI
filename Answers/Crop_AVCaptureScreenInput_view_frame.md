```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to crop AVCaptureScreenInput to a swiftui view frame? (by ojii)

A: The idea is to use view modifier for a specific view which we want
to capture, so it returns us a rect which we then pass into `AVCaptureScreenInput`
crop rect.

Important part that view with prepared rect can be created *before* real window
is present to convert that rect to screen coordinates, so convertation is better
to perform right before recording.

Tested with Xcode 13.3 / macOS 12.2

![ezgif com-gif-maker-38](https://user-images.githubusercontent.com/62171579/164056477-bec5b5ff-08fb-410d-9f58-db337144d8c3.gif)


So we want something like
```
DemoView()
  .gettingInWindow(rect: $viewRect)   // << read rect of view !!
  
// ...

recording = recorder.startRecording(to: destinationURL, in: viewRect)  // << inject it to recorder

```

the the view modifier and corresponding extension will be as

```
extension View {
  func gettingInWindow(rect: Binding<CGRect>) -> some View {
    self.modifier(ReadInWindowRectModifier(rect: rect))
  }
}

struct ReadInWindowRectModifier: ViewModifier {
  @Binding var rect: CGRect
  func body(content: Content) -> some View {
    VStack {
      content.background(GeometryReader {
        Color.clear.preference(key: ViewRectKey.self, value: $0.frame(in: .global))
      })
    }
    .onPreferenceChange(ViewRectKey.self) {
      rect = $0
    }
  }
}
```

The [test module in the PlayOn_macOS project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_macOS/PlayOn_macOS/Findings/TestScreenRecordingInView.swift)
