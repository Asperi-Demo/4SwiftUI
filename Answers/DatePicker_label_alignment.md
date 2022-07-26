```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Change text alignment of DatePicker in SwiftUI 2.0 iOS 14 (by Ludyem)

A: Here is possible solution. Tested with Xcode 12 / iOS 14

![m4b94](https://user-images.githubusercontent.com/62171579/169689951-4f8b1783-d96a-436e-b4b2-d3848f994b85.png)

```
DatePicker(selection: $birthDate, in: ...Date().stripTime(), displayedComponents: .date) {
      Text("Birthday").frame(maxWidth: .infinity, alignment: .trailing)
}.fixedSize().frame(maxWidth: .infinity, alignment: .trailing)
```


**Update:**

![P6FnA](https://user-images.githubusercontent.com/62171579/169689948-6c221822-11ac-44fe-8fe1-d9e5ace09036.png)

    HStack {
        Text("Birthday")
        Spacer()
        DatePicker("", selection: $birthDate, in: ...Date().stripTime(), displayedComponents: .date)
            .fixedSize()
    }

