```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Applying opacity to ZStack in SwiftUI (by f3dm76)

A: If the blue rect should not be visible under the green one, because the opacity should be applied to them both as a group, 
not individually to each of them one by one, it should be use compositing group *before* opacity modifier, like

![zXXtQ](https://user-images.githubusercontent.com/62171579/166717882-4da62c52-8f2b-4c03-a745-cc13f50e2e75.png)

    return ZStack {
        let r = Rectangle()
          .foregroundColor(.blue)
          .frame(width: 80, height: 40)
          .position(x: 60, y: 110)

        let r2 = Rectangle()
          .foregroundColor(.green)
          .frame(width: 80, height: 40)
          .position(x: 70, y: 120)

        r
        r2
    }
    .compositingGroup()    // << here !!
    .opacity(0.5)

