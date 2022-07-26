```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Save ScrollViews position and scroll back to it later (offset to position) (by L3n95)

A: You don't need actually offset in this scenario, just store id of currently visible view (you can use any appropriate algorithm for your data of how to detect it) and then scroll to view with that id.

Here is a simplified demo of possible approach. Tested with Xcode 12.1/iOS 14.1

![ki5mX](https://user-images.githubusercontent.com/62171579/175981353-16a04785-44d2-4045-94d6-49c2d96ed52d.gif)

```
struct TestScrollBackView: View {
  @State private var stored: Int = 0
  @State private var current: [Int] = []
  
  var body: some View {
    ScrollViewReader { proxy in
      VStack {
        HStack {
          Button("Store") {
                        // hard code is just for demo !!!
            stored = current.sorted()[1] // 1st is out of screen by LazyVStack
            print("!! stored \(stored)")
          }
          Button("Restore") {
            proxy.scrollTo(stored, anchor: .top)
            print("[x] restored \(stored)")
          }
        }
        Divider()
        ScrollView {
          LazyVStack {
            ForEach(0..<1000, id: \.self) { obj in
              Text("Item: \(obj)")
                .onAppear {
                  print(">> added \(obj)")
                  current.append(obj)
                }
                .onDisappear {
                  current.removeAll { $0 == obj }
                  print("<< removed \(obj)")
                }.id(obj)
            }
          }
        }
      }
    }
  }
}
```
