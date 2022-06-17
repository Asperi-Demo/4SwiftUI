```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - Adding a keyboard toolbar button for only one TextField adds it for all TextFields (by Jimbo)

A: Try to make toolbar content conditional and move toolbar outside, like below. (No possibility to test now - just idea)

Note: test on real device

    var body: some View {
        VStack {
            Spacer()
            
            TextField("A text field here", text: $str)
                .focused($focusedField, equals: .str)

            TextField("", value: $num, formatter: FloatNumberFormatter())
                .focused($focusedField, equals: .amount)
                .keyboardType(.decimalPad)

            Spacer()
        }
        .toolbar {          // << here !!
            ToolbarItem(placement: .keyboard) {
                if field == .amount {             // << here !!
                   Button("Done") {
                      focusedField = nil
                   }
                }
            }
        }

    }

