```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Swift ui macOS popover on the button or on an image (by Paul)

A: Here is demo of possible approach. Prepared & tested with Xcode 11.7 / macOS 10.15.6

![hL76e](https://user-images.githubusercontent.com/62171579/167460635-ba638e18-feb5-4830-bce6-3fe03bad658b.png)

```
struct ContentView: View {
    @State var isPopover = false
    var body: some View {
        VStack {
            Button(action: { self.isPopover.toggle() }) {
                Image(nsImage: NSImage(named: NSImage.infoName) ?? NSImage())
            }.popover(isPresented: self.$isPopover, arrowEdge: .bottom) {
                     PopoverView()
            }.buttonStyle(PlainButtonStyle())
        }.frame(width: 800, height: 600)
    }
}

struct PopoverView: View {
    var body: some View {
        VStack {
            Text("Some text here ").padding()
            Button("Resume") {
            }
        }.padding()
    }
}
```
