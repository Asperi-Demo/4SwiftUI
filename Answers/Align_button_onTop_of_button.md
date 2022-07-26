```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to align the an image on top of a button in swiftui? (by mic)

A: Here is a demo of possible approach. Tested with Xcode 11.4 / iOS 13.4 (with some replicated code)

![SddMh](https://user-images.githubusercontent.com/62171579/177529069-6a013dae-6ca5-4d5e-8e96-9c2ac4094611.png)

    var body: some View {
           Button(action: { }) {
            Text("Name")
           }
           .buttonStyle(GradientBackgroundStyle(isTapped: tapped))
           .overlay(Group {
                if self.isEdit {
                    ZStack {
                        Button(action: {print(">> Trash Tapped")}) {
                           Image(systemName: "trash")
                                .foregroundColor(.red).font(.title)
                        }.padding(.trailing, 40)
                        .alignmentGuide(.top) { $0[.bottom] }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)

                }
           })
           .padding(.bottom, 20)
    }
