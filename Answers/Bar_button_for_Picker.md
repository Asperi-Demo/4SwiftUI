```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to add a navigation bar button to a picker (by G. Marc)

A: Changing `diaplayMode` on the fly always gives undesired effect, but if you'd have same one (or none for Options) then the following approach could work.

Tested with Xcode 11.4 / iOS 13.4

![ocVh1](https://user-images.githubusercontent.com/62171579/180512257-e33c20ee-6d25-4d8b-9e60-34691f1f4465.gif)

```
struct ContentView: View {
    @State private var selection = 1
    @State private var options = [Option(title: "Option 1", id: 1), Option(title: "Option 2", id: 2)]

    struct Option {
        var title: String
        var id: Int
    }

    var body: some View {
        NavigationView {
            Form {
                Picker("Test", selection: $selection) {
                    ForEach(options, id:\.id) { option in
                        self.optionRow(for: option)
                    }
                    .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                }
            }
            .navigationBarTitle("Form")
//            .navigationBarTitle("Form", displayMode: .inline)
        }
    }

    @ViewBuilder
    func optionRow(for item: Option) -> some View {
        if item.id == selection {
            Text(item.title)
        } else {
            Text(item.title)
                .navigationBarTitle("Options")
//                .navigationBarTitle("Options", displayMode: .inline)
                .navigationBarItems(trailing: Button("Add") {
                    // example of creating new option
                    self.options.append(Option(title: "Option 3", id: 3))
                })
        }
    }
}
```
