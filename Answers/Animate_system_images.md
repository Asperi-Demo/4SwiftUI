```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: Unable to animate images (by Master AgentX)

A: Here is possible approach. I simplified it for a demo purpose and less posting code, but idea should be clear and easy transferrable to your real code

Result demo (really it is much fluent than on gif):

![ezgif com-gif-maker-47](https://user-images.githubusercontent.com/62171579/175868380-3935e6bf-0db3-4b33-a7ea-e4f515501a22.gif)


Modified model

    enum SpeakerSymbol: Int, CaseIterable { // Inherited from Int for convenient below
    
        case speakerEmpty, speaker1, speaker2, speaker3
        
        var image: some View {
            var name: String
            switch self {
            case .speakerEmpty: name = "speaker.slash.fill"
            case .speaker1: name = "speaker.1.fill"
            case .speaker2: name = "speaker.2.fill"
            case .speaker3: name = "speaker.3.fill"
            }
            return Image(systemName: name).font(.largeTitle)
        }
    }

Animatable modifier for SpeakerSymbol, required to let SwiftUI animation know that changed SpeakerSymbol value is able to animate

    struct SpeakerModifier: AnimatableModifier {
        var symbol: SpeakerSymbol
        
        init(symbol: SpeakerSymbol) {
            self.symbol = symbol
            self.animating = Double(symbol.rawValue) // enum to Double
        }
        
        private var animating: Double // Double supports Animatable
        var animatableData: Double { // required part of Animatable protocol
            get { animating }
            set { animating = newValue }
        }
        
        func body(content: Content) -> some View {
            return SpeakerSymbol(rawValue: Int(animating))!.image // Double -> enum
        }
    }

Demo of usage

    struct TestSpeakerModifier: View {
        @State private var speaker: SpeakerSymbol = .speakerEmpty
    
        var body: some View {
            VStack {
                Color.clear // << just holder area
                    .modifier(SpeakerModifier(symbol: speaker))
                    .frame(width: 60, height: 60, alignment: .leading)
                Divider()
                Button("Toggle") {
                    withAnimation { // animates between enum states
                        self.speaker = 
                           (self.speaker == .speakerEmpty ? .speaker3 : .speakerEmpty)
                    }
                }
            }
        }
    }


