```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - Responding to taps in parent View (by Andrew Duncan)

A: Here is possible approach with optional external event generator, so if one provided reusable view reacts on external provider as well as on local (if local is not needed, then it can be just removed).

Tested with Xcode 11.4 / iOS 13.4

![7u9sa](https://user-images.githubusercontent.com/62171579/170254564-4c5b870c-73c4-46f6-b02e-77a174f9557b.gif)

Full module code:

    import SwiftUI
    import Combine
    
    struct MyReusableSubview : View {
        private let publisher: AnyPublisher<Bool, Never>
        init(_ publisher: AnyPublisher<Bool, Never> = 
                          Just(false).dropFirst().eraseToAnyPublisher()) {
            self.publisher = publisher
        }
    
        @State private var offs = CGFloat.zero  // Animate this.
    
        var body: some View {
            Rectangle().foregroundColor(.green).offset(y: self.offs)
    
            // A local event triggers the action...
            .onTapGesture { self.simplifiedAnimation() }
            .onReceive(publisher) { _ in self.simplifiedAnimation() }
            // ...but we want to animate when parent view says so.
        }
    
        private func simplifiedAnimation() {
            self.offs = 200
            withAnimation { self.offs = 0 }
        }
    }
    
    struct TestParentToChildEvent: View {
        let generator = PassthroughSubject<Bool, Never>()
        var body: some View {
            VStack {
                Button("Tap") { self.generator.send(true) }
                Divider()
                MyReusableSubview(generator.eraseToAnyPublisher())
                    .frame(width: 300, height: 200)
            }
        }
    }
    
This demo seems simplest for me, also it is possible indirect dependency injection of external generator via Environment instead of constructor.
