```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Is it correct to expect internal updates of a SwiftUI DynamicProperty property wrapper to trigger a view update? (by Pop Flamingo)

A: Ok... here is alternate approach to get similar thing... but as struct only `DynamicProperty` wrapped around `@State` (to force view refresh).

It is simple wrapper but gives possibility to incapsulate any custom calculations with following view refresh... and as said using value-only types.

Here is demo (tested with Xcode 11.2 / iOS 13.2):

![nfhTC](https://user-images.githubusercontent.com/62171579/165106390-e1106ce4-d2dd-486f-977d-54f15b5280e8.gif)


Here is code:

    import SwiftUI
    
    @propertyWrapper
    struct Refreshing<Value> : DynamicProperty {
        let storage: State<Value>
    
        init(wrappedValue value: Value) {
            self.storage = State<Value>(initialValue: value)
        }
        
        public var wrappedValue: Value {
            get { storage.wrappedValue }
            
            nonmutating set { self.process(newValue) }
        }
        
        public var projectedValue: Binding<Value> {
            storage.projectedValue
        }
        
        private func process(_ value: Value) {
            // do some something here or in background queue
            DispatchQueue.main.async {
                self.storage.wrappedValue = value
            }
        }
        
    }

    
    struct TestPropertyWrapper: View {
        
        @Refreshing var counter: Int = 1
        var body: some View {
            VStack {
                Text("Value: \(counter)")
                Divider()
                Button("Increase") {
                    self.counter += 1
                }
            }
        }
    }
    
