>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How to enable both wipe able tabview and bottom navigator in swiftUi (by Stevie)

A: A possible approach is to use two synchronised `TabView` for this purpose by matching selections and aligned content height. See also comments inline.

Tested with Xcode 13.2 / iOS 15.2

![emoL1](https://user-images.githubusercontent.com/62171579/189472074-c5160964-eb3f-4235-a1fb-b2f617c1b766.gif)

```
struct TestTwoTabViews: View {
    @State private var selection1: Int = 1
    @State private var selection2: Int = 1

    // to make 2d TabView as height as content view of 1st TabView
    @State private var viewHeight = CGFloat.infinity

    var body: some View {
        ZStack(alignment: .top) {

            // responsible for bottom Tabs
            TabView(selection: $selection1) {
                Color.clear
                    .background(GeometryReader {
                        // read 1st content height
                        Color.clear.preference(key: ViewHeightKey.self,
                                               value: $0.frame(in: .local).size.height)
                    })
                    .tabItem{Image(systemName: "1.square")}.tag(1)
                Color.clear
                    .tabItem{Image(systemName: "2.square")}.tag(2)
                Color.clear
                    .tabItem{Image(systemName: "3.square")}.tag(3)
            }

            // responsible for paging
            TabView(selection: $selection2) {
                Color.yellow.overlay(Text("First"))
                    .tag(1)
                Color.green.overlay(Text("Second"))
                    .tag(2)
                Color.blue.overlay(Text("Third"))
                    .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxHeight: viewHeight)   // content height
        }
        .onPreferenceChange(ViewHeightKey.self) {
            self.viewHeight = $0  // apply content height
        }
        .onChange(of: selection1) {
        	selection2 = $0  // sync second
        }
        .onChange(of: selection2) {
        	selection1 = $0  // sync first
        }
    }
}

struct ViewHeightKey: PreferenceKey {
	static var defaultValue: CGFloat { 0 }
	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = value + nextValue()
	}
}

```
