```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Dynamic height for shapes in SwiftUI (by umayanga)

A: Here is possible approach. Tested with Xcode 11.4 / iOS 13.4

![DgS7D](https://user-images.githubusercontent.com/62171579/177105262-5c9da9c4-d808-4475-a9e0-299e91bcf1cd.png)

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(self.notes, id: \.self) {note in
                HStack {
                    Text(note)
                        .padding(.leading)
                }
                .overlay(Capsule()       // also can be .background
                            .fill(Color.blue)
                            .frame(width: 4.5), alignment: .leading)
                .padding()
            }
        }
    }
