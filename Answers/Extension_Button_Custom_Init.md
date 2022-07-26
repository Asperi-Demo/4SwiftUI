```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Struggling with creating extension for Button in SwiftUI (by MohAliBou)

A: There is a couple of things here - first we need to align input arguments types and
resolve generics requirements, which is not obvious becuase Label typealias in Button has same
notation as real type we need to use. So to solve the last we need to specify SwiftUI module
explicitly as show below.

```
extension Button {
  init(_ title: LocalizedStringKey, systemImage: String, action: @escaping () -> Void) where Label == SwiftUI.Label<Text, Image> {
    self.init(action: action, label: {
      SwiftUI.Label(title, systemImage: systemImage)
    })
  }
}
```

and the usage then

    Button("Button", systemImage: "person") {
      print("pressed")
    }

Tested with XCode 13.3 / iOS 15.4

![Screenshot 2022-04-15 at 09 23 03](https://user-images.githubusercontent.com/62171579/163530188-0df2802b-efd2-4133-83e4-1ea116beb5e4.png)

[A documented extension in code is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Extensions/Button%2B.swift)
