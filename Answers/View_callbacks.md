```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI callback as parameter to a view (by Panos)

A: Below variant works. Tested with Xcode 11.4.

    struct MainView: View {
        var body: some View {
             VStack {
                 MyContentView(doSomething: self.doSomething)
                 MenuView(doSomething: self.doSomething)
             }
        }
    
        func doSomething() {
            print("do something")
        }
    }
    
    struct MyContentView : View {
        var doSomething : () -> ()
        var body: some View {
            Button(action: { self.doSomething() }) { Text("do something") }
        }
    }
    
    struct MenuView : View {
        var doSomething : () -> ()
        var body: some View {
            Button(action: { self.doSomething() }) { Text("Menu do something") }
        }
    }

