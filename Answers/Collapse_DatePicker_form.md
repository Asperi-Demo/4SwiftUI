```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to automatically collapse DatePicker in a form when other field is being edited? (by Igor R.)

A: Here is possible approach. The idea is to reset `DatePicker` component for each of events result in editing.

Tested with Xcode 11.4 / iOS 13.4

    struct AddItemView: View {
        @State private var title = ""
        @State private var date = Date()
        @State private var pickerReset = UUID()
    
        var body: some View {
            Form {
                Section {
                    TitleTextField()
    
                    DatePicker(
                        selection: $date,
                        in: Date()...,
                        displayedComponents: .date,
                        label: { Text("Date") }
                    ).id(self.pickerReset)
                }
            }
        }
    
        private func TitleTextField() -> some View {
            let boundText = Binding<String>(
                get: { self.title },
                set: { self.title = $0; self.pickerReset = UUID() }
            )
            return TextField("Title", text: boundText, onEditingChanged: { editing in
                if editing {
                    self.pickerReset = UUID()
                }
            })
        }
    }

