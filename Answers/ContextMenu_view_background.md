```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - context menu background colour (by Ramachandiran J A)

A: Context menu caches content and reuse it all the time. Here is possible solution to force update it.

Tested with Xcode 11.4 / iOS 13.4

![oG02y](https://user-images.githubusercontent.com/62171579/177029345-fdc255e7-4b20-4a06-ad2b-3f4a9186b709.gif)

```
HStack {
    Rectangle().fill(bgColor) // << use same color
        .frame(width: 120, height: 120)
        .border(Color.black, width: 1)
        .contextMenu{
            VStack {
                Button("Orange",action: {
                    self.bgColor = Color.orange
                })

                Button("Green",action: {
                    self.bgColor = Color.green
                })

                Button("Red",action: {
                    self.bgColor = Color.red
                })
            }
        }.id(UUID())      // << force recreate context menu
}.frame(width:UIScreen.main.bounds.width, height: 200).background(bgColor)
```
