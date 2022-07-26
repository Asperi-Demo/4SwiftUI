```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Why does this SwiftUI Picker code not work? (by Vince O'Sullivan)

A: ForEach types inside Picker should be aligned with selection type.

Here is a corrected code that should work for you:


    @State private var letter = ""
    private let letters = ["Alpha", "Bravo", "Charlie"]
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Select a letter", selection: $letter) {
                    ForEach(letters, id: \.self) { option in
                        Text(option)
                    }
                }
                Text("Selected letter: \(letter)")
            }
            .navigationBarTitle("Main Menu")
        }
    }

