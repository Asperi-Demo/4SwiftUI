```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Swift: how to apply "acceptsFirstMouse" for app build with SwiftUI? (by Andrew____Pls_Support_Ukraine)

A: Well, for now there is no such instrument in SwiftUI API, but... it is not standalone in a desert, and Apple did not say that it is a replacement for Cocoa, moreover they show us how to integrate them and use best of both...

So, here is possible approach...

    import SwiftUI
    import Cocoa
    
    // Just mouse accepter
    class MyViewView : NSView {
        override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
            return true
        }
    }
    
    // Representable wrapper (bridge to SwiftUI)
    struct AcceptingFirstMouse : NSViewRepresentable {
        func makeNSView(context: NSViewRepresentableContext<AcceptingFirstMouse>) -> MyViewView {
            return MyViewView()
        }
    
        func updateNSView(_ nsView: MyViewView, context: NSViewRepresentableContext<AcceptingFirstMouse>) {
            nsView.setNeedsDisplay(nsView.bounds)
        }
    
        typealias NSViewType = MyViewView
    }
    
    // Usage (somewhere in your SwiftUI view stack)
    ...
          Text("Click me")
            .padding(20)
            .background(Color.yellow)
            .overlay(AcceptingFirstMouse()) // must be on top (no confuse, it is transparent)
            .onTapGesture {
                print("Label tapped")
            }
    ...

