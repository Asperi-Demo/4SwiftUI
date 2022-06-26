```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to change selected value of swiftUI DatePicker programmatically (by Robac)

```
struct FormWithPicker: View {
    @StateObject var formValues = FormValues()
    
    var body: some View {
        NavigationView {
            Form{
                // invoice date
                DatePicker("Invoice Date:", selection: $formValues.invoiceDate, displayedComponents: [.date])
                
                // terms
                Picker("Terms:", selection: $formValues.invoiceTerms) {
                    ForEach(formValues.terms, id: \.self) { term in
                        Text(term)
                    }
                }
                .onChange(of: formValues.invoiceTerms, perform: { _ in
                    formValues.incrementDueDate()
                })
                
                // due date
                DatePicker("Due Date:", selection: $formValues.dueDate, displayedComponents: [.date])
                    
                // text
                Text(formValues.dueDate.description)
                
            }
        }
    }
}
```
A: We need to make dependent `DatePicker` on externally changed `dueDate` and rebuild it. The `.id` modifier is good for this, like

    DatePicker("Due Date:", selection: $formValues.dueDate, displayedComponents: [.date])
		.id(formValues.dueDate)    // << here !!

Tested with Xcode 13.2 / iOS 15.2

