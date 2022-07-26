```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to translate bindings in a view? (by G. Marc)

A: Here is the approach based on the `Binding(get:set:)`

    struct TimePicker: View {
        @Binding var total: Int
        
        var minutes: Binding<Int> {
            Binding<Int>(get: { self._total.wrappedValue / 60 },
                         set: { self._total.wrappedValue = self._total.wrappedValue % 60 + $0 * 60 })
        }
    
        var seconds: Binding<Int> {
            Binding<Int>(get: { self._total.wrappedValue % 60 },
                         set: { self._total.wrappedValue = (self._total.wrappedValue / 60) * 60 + $0 })
        }
        
        var body: some View {
            HStack() {
                Spacer()
                Picker(selection: minutes, label: EmptyView()) {
                    ForEach((0...9), id: \.self) { ix in
                        Text("\(ix)").tag(ix)
                    }
                }.pickerStyle(WheelPickerStyle()).frame(width: 50).clipped()
                Text("Min.")
                Picker(selection: seconds, label: EmptyView()) {
                    ForEach((0...59), id: \.self) { ix in
                        Text("\(ix)").tag(ix)
                    }
                    }.pickerStyle(WheelPickerStyle()).frame(width: 50).clipped()
                Text("Sec.")
                Spacer()
            }.frame(height: 200)
        }
    }
    
    struct TestTimePicker: View {
        
        @State var seconds = 185
        var body: some View {
            VStack {
                Text("Current: \(seconds)")
                TimePicker(total: $seconds)
            }
        }
        
    }
    
