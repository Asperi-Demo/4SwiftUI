```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to loop through keys in struct for SwiftUI? (by phantomhive)

A: Here is a demo of possible approach (for this simple case) - you can reflect properties and map them to shown values (for custom/complex types it will require more efforts by idea should be clear).

    struct Product: Hashable, Codable{
       var column0: Int
       var column1: String
       var column2: String
       var column3: String
       var column4: String
    }

    var pdt: Product

    var body: some View {
        let columnValues = Mirror(reflecting: pdt)
                              .children.map { "\($0.value)" }
        return HStack {
            ForEach(columnValues, id: \.self) { Text($0) }
        }
    }
