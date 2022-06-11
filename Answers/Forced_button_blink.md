```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Button blink animation with SwiftUI (by Okzhetpes)

A: Hope the following approach would be helpful. It is based on ViewModifier and can be controlled by binding. Speed of animation as well as animation kind itself can be easily changed by needs.

*Note: Although there are some observed drawbacks: due to no didFinish callback provided by API for Animation it is used some trick to workaround it; also it is observed some strange handling of Animation.repeatCount, but this looks like a SwiftUI issue.*

Anyway, here is a demo (screen flash at start is launch of Preview): a) activating blink in onAppear b) force activating by some action, in this case by button

![ezgif com-gif-maker-28](https://user-images.githubusercontent.com/62171579/173181253-13ae8501-27d9-4aa8-99bc-bb7f9c8b695a.gif)


    struct BlinkingBorderModifier: ViewModifier {
        let state: Binding<Bool>
        let color: Color
        let repeatCount: Int
        let duration: Double
    
        // internal wrapper is needed because there is no didFinish of Animation now
        private var blinking: Binding<Bool> {
            Binding<Bool>(get: {
                DispatchQueue.main.asyncAfter(deadline: .now() + self.duration) {
                    self.state.wrappedValue = false
                }
                return self.state.wrappedValue }, set: {
                self.state.wrappedValue = $0
            })
        }
        
        func body(content: Content) -> some View
        {
            content
                .border(self.blinking.wrappedValue ? self.color : Color.clear, width: 1.0)
                .animation( // Kind of animation can be changed per needs
                    Animation.linear(duration:self.duration).repeatCount(self.repeatCount)
                , value: .blinking.wrappedValue)
        }
    }
    
    extension View {
        func blinkBorder(on state: Binding<Bool>, color: Color,
                         repeatCount: Int = 1, duration: Double = 0.5) -> some View {
            self.modifier(BlinkingBorderModifier(state: state, color: color,
                                                 repeatCount: repeatCount, duration: duration))
        }
    }
    
[Test module is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestButtonBlinkForcing.swift)
