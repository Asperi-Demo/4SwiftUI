```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Swift 5.+ - Making a class hashable? (by Gerry)

A: Here is an example for using class-based model in the described use-case. Tested with Xcode 11.4

```
class Stuff: Hashable, Equatable {
    static func == (lhs: Stuff, rhs: Stuff) -> Bool {
        lhs.title == rhs.title
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }

    var title: String = ""
}

struct StaffView: View {
    let listOfStaff: [Stuff]

    var body: some View {
        ScrollView {
            ForEach(listOfStaff, id: \.self) { stuff in
                Text(stuff.title)
            }
        }
    }
}
```
