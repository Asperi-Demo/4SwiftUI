```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How can I make a Generic PreferenceKey in SwiftUI? (by swiftPunk)

A: Here is a possible approach to move with. Tested as worked with Xcode 12.4 / iOS 14.4

```
protocol Initable {
	init()
}

extension String: Initable {
}

struct CustomPreferenceKey<T: Equatable & Initable>: PreferenceKey {
    typealias Value = T

    static var defaultValue: T { get { T() } }

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct ContentView: View {

    @State private var stringOfText: String = "Hello, world!"

    var body: some View {

        Text(stringOfText)
            .preference(key: CustomPreferenceKey<String>.self, value: stringOfText)
            .onPreferenceChange(CustomPreferenceKey<String>.self) { newValue in print(newValue) }
    }
}
```
