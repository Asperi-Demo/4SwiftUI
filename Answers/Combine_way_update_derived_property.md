```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to implement derived property using Combine? (by G. Marc)

A: Here is possible approach (tested with Xcode 11.2 / iOS 13.2)

    class Demo: ObservableObject {
        @Published var propertyA: Bool = false
        @Published var propertyB: Bool = false
    
        @Published var propertyC: Bool = false
    
        private var subscribers = Set<AnyCancellable>()
        init() {
            Publishers.CombineLatest(_propertyA.projectedValue, _propertyB.projectedValue)
                .receive(on: RunLoop.main)
                .map { $0 && $1 }
                .assign(to: \.propertyC, on: self)
                .store(in: &subscribers)
        }
    }
    
    // view for testing, works in Preview as well
    struct FastDemoTest: View {
        @ObservedObject var demo = Demo()
        var body: some View {
            VStack {
                Button("Toggle A") { self.demo.propertyA.toggle() }
                Button("Toggle B") { self.demo.propertyB.toggle() }
                Divider()
                Text("Result of C: \( demo.propertyC ? "true" : "false" )")
            }
        }
    }

