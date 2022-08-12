>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI List selection doesn’t show If I add a NavigationLink and a .contextMenu to the list. Is this a known bug? (by Fawzi Rifa'i)

A: We can disable context menu button(s) for the moment of construction in edit mode (because the button is a reason of issue).

Here is a possible approach - some redesign is required to handle `editMode` inside context menu (see also comments inline). 

Tested with Xcode 13.2 / iOS 15.2

![SSTDa](https://user-images.githubusercontent.com/62171579/184379840-48031655-87af-45c8-962c-5ba5d533ce74.gif)

```
struct ContentViewSelection: View {
    @State private var selection: String?
    let names = ["Cyril", "Lana", "Mallory", "Sterling"]

    var body: some View {
        NavigationView {
            List(names, id: \.self, selection: $selection) { name in
                // separated view is needed to use editMode
                // environment value
                NameCell(name: name)
            }
            .toolbar {
                EditButton()
            }
        }
    }
}

struct NameCell: View {
    @Environment(\.editMode) var editMode     // << !!
    let name: String

    var body: some View {
        NavigationLink(destination: Text("Hello, world!")) {
            Text(name)
        }
        .contextMenu {
            if editMode?.wrappedValue == .inactive {    // << !!
                Button(action: {}) {
                    Text("Tap me!")
                }
            }
        }
    }
}
```
