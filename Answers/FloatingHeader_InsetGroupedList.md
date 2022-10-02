>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: swiftui list with custom image header (by mars)

A: It can be done making list row background transparent, like

```
List {
    Section() {
        VStack() {
            Image("HeadImage")
                .resizable()
                .frame(width: 50, height: 50)
            Text("Test word")
                .foregroundColor(Color.red)

        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 150)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)     // << here !!
    }
    ForEach(...) {
      // rows here
    }
}
```

Tested with Xcode 13.4 / iOS 15.5

![YFDkk](https://user-images.githubusercontent.com/62171579/193442489-9cfea833-02f5-41f2-9c8b-60a3d93903ed.png)
