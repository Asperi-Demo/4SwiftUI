```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - How to change the checkmark color of a Picker which is nested in a Form (by Kuhlemann)

A: Here it is (tested with Xcode 11.4-13.3)

![cMujX](https://user-images.githubusercontent.com/62171579/169640075-97cd31b6-d179-4bba-878c-67ccbd70b4e8.png)

    var body: some View {
        NavigationView {
            Form {
                Section(header:Text("").font(.title)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                ){
                    Picker(selection: $selectedMode, label: Text("Modes")) {
                        ForEach(0 ..< modes.count, id: \.self) {
                            Text(self.modes[$0])
                                .foregroundColor(Color.red)
                        }
                    }
                }
            }
        }.accentColor(Color.black)   // << fix here !!
    }


**Note:** `.accentColor` is applied for all `NavigationView` controls, so `UINavigationBar.appearance().tintColor = .black` is not needed.
