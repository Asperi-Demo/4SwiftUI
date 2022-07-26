```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Swift UI need to keep both NavigationLink to detail view and Tap gesture recognizer (by Async-)

A: Actually it should work, but it is not due to bug of `.all GestureMask`. I submitted feedback to Apple #FB7672055, and recommend to do the same for everybody affected, the more the better.

Meanwhile, here is possible alternate approach/workaround to achieve similar effect.

Tested with Xcode 11.4 / iOS 13.4

```
extension UIApplication {  // just helper extension
    static func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}

struct TestEndEditingOnNavigate: View {
    @State private var cities = ["London", "Berlin", "New York"]
    @State private var searchTerm = ""
    @State private var tappedLink: String? = nil // track tapped link

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Search", text: $searchTerm)
                }

                Section {
                    List {
                        ForEach(cities, id: \.self) { city in
                            self.link(for: city) // decompose for simplicity
                        }
                    }
                }
            }
            .navigationBarTitle("City list")
        }
    }

    private func link(for city: String) -> some View {
        let selection = Binding(get: { self.tappedLink }, // proxy bindng to inject...
            set: {
                UIApplication.endEditing()           // ... side effect on willSet
                self.tappedLink = $0
        })
        return NavigationLink(destination: Text("city: \(city)"), tag: city, selection: selection) {
            Text("\(city)")
        }
    }
}
```
