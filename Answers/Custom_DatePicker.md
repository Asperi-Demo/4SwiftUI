```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: how to create custom UIDatePicker? (by Nayef)

A: Here is possible approach. Tested with Xcode 11.2 / iOS 13.2

    struct DatePicker: UIViewRepresentable {
        @Binding var date: Date
    
        func makeUIView(context: Context) -> UIDatePicker {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.addTarget(context.coordinator, action: #selector(Coordinator.changed(_:)), for: .valueChanged)
            return datePicker
        }
    
        func updateUIView(_ datePicker: UIDatePicker, context: Context) {
            datePicker.date = date
        }
    
        func makeCoordinator() -> DatePicker.Coordinator {
            Coordinator(date: $date)
        }
    
        class Coordinator: NSObject {
            private let date: Binding<Date>
    
            init(date: Binding<Date>) {
                self.date = date
            }
    
            @objc func changed(_ sender: UIDatePicker) {
                self.date.wrappedValue = sender.date
            }
        }
    }

