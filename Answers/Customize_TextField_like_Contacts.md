```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI customized text field in OSX (by davidev)

A: Well, in general all we need is `PlainTextFieldStyle`, but as currently 
SwiftUI does not allow to turn off focus ring there is some workaround below to disable it globally for all text fields. 

Anyway... I think worth posting, so here it is (tested with Xcode 11.3)

![Uqeii](https://user-images.githubusercontent.com/62171579/167285745-f614c8f2-4eea-48dc-88e1-c840f9310494.png)

    extension NSTextField { // << workaround !!!
        open override var focusRingType: NSFocusRingType {
            get { .none }
            set { }
        }
    }
    
    struct ContentView: View {
        @State private var text = ""
        var body: some View {
            HStack {
                Text("Mobil")
                TextField("", text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(1)
                    .background(RoundedRectangle(cornerRadius: 2).stroke(Color.white))
                    .frame(width: 100)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        }
    }
