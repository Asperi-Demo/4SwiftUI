```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: NavigationView in iPad popover does not work properly in SwiftUI (by Sorin Lica)

A: Probably on iPad they've got into chicken-egg problem with size detection, so just finalised with minimum.

Anyway, the solution would be to set `.frame` explicitly, either with predefined values (for iPad it is not so bad), or with dynamically calculated (eg. from outer frame via `GeometryReader`)

Here is an example. Tested with Xcode 12 / iPadOS 14

![OD62P](https://user-images.githubusercontent.com/62171579/167766507-727215ce-4d9b-4d38-baf3-9f8546f7a603.png)

```
struct TestPopover: View {

    @State private var show = false

    var body: some View {
        GeometryReader { gp in
            VStack {
                Button("Open") {
                    self.show.toggle()
                }.popover(isPresented: $show, content: {
                    NavigationView {
                        ScrollView {   // or List
                            ForEach(0...10, id: \.self) {_ in
                                Text("Test popover ...")
                            }.padding()
                        }
                        .navigationBarTitle("Test", displayMode: .inline)
                    }
                    .frame(width: gp.size.width / 3, height: gp.size.height / 3)
                })
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
```

**Variant 2:** Partially calculated on outer size, partially on inner size.

![Zxac7](https://user-images.githubusercontent.com/62171579/167766543-2d437325-3ead-4329-97fa-fca750298d23.png)

```
struct TestPopover: View {

    @State private var show = false
    @State private var popoverWidth = CGFloat(100)

    var body: some View {
        GeometryReader { gp in
            VStack {
                Button("Open") {
                    self.show.toggle()
                }.popover(isPresented: $show, content: {
                    NavigationView {
                        ScrollView {   // or List
                            ForEach(0...10, id: \.self) {_ in
                                Text("Test popover ...").fixedSize()
                            }.padding()
                            .background(GeometryReader {
                                Color.clear
                                    .preference(key: ViewWidthKey.self, value: $0.frame(in: .local).size.width)
                            })
                            .onPreferenceChange(ViewWidthKey.self) {
                                self.popoverWidth = $0
                            }
                        }
                        .navigationBarTitle("Test", displayMode: .inline)
                    }
                    .frame(width: self.popoverWidth, height: gp.size.height / 3)
                })
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ViewWidthKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

```
