```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI gestures in the toolbar area ignored (by Tamas)

A: Looks like design limitation (or not implemented yet feature - Apple does not see such view as user interaction capable item).

A possible workaround is to wrap you active element into button style. The button as a container interpreted as user-interaction-able area but all drawing and handling is in your code.

Tested with Xcode 13.2 / macOS 12.2

*Note: no changes in your slider logic*

![9ARF1](https://user-images.githubusercontent.com/62171579/174335597-f780c587-4d41-434f-a86e-56656705a641.gif)

  struct MySlider: View {

    var body: some View {
      Button("") {}.buttonStyle(SliderButtonStyle())
    }

    struct SliderButtonStyle: ButtonStyle {
      func makeBody(configuration: Configuration) -> some View {
        MySliderContent()
      }

      struct MySliderContent: View {
        @State var offset: CGFloat = 0.0
        var body: some View {
          GeometryReader { gr in
            let thumbSize = gr.size.height
            let maxValue = (gr.size.width - thumbSize) / 2.0
            let gesture = DragGesture(minimumDistance: 0).onChanged { v in
              self.offset = max(min(v.translation.width, maxValue), -maxValue)
            }
            ZStack {
              Capsule()
              Circle()
                .foregroundColor(Color.yellow)
                .frame(width: thumbSize, height: thumbSize)
                .offset(x: offset)
                .highPriorityGesture(gesture)
            }
          }.frame(width: 100, height: 20)
        }
      }
    }
  }

