```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to add confirmation to .ondelete() of List in SwiftUI (by T. Karter)

A: Here is possible approach:

```
@State private var toBeDeleted: IndexSet?

...

List {
    ForEach(data, id: \.self) { item in
        Text(item)
        .alert(isPresented: self.$showingDeleteAlert) {
            Alert(title: Text("..."), message: Text("..."), primaryButton: .destructive(Text("Delete")) {
                    for index in self.toBeDeleted {
                        let item = data[index]
                        viewContext.delete(item)
                        do {
                            try viewContext.save()
                        } catch let error {
                            print("Error: \(error)")
                        }
                    }
                    self.toBeDeleted = nil
                }, secondaryButton: .cancel() {
                    self.toBeDeleted = nil
                }
            )
        }
    }
    .onDelete(perform: deleteRow)
}

func deleteRow(at indexSet: IndexSet) {
    self.toBeDeleted = indexSet           // store rows for delete
    self.showingDeleteAlert = true
}
```
