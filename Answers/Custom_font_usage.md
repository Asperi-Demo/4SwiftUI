```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Custom font not showing up in SwiftUI (by Zorgan)

A: Here is my steps (demo prepared & tested with Xcode 12 / iOS 14):

1) taken font for demo from  http://fdempreendimentos.com.br/assets/fonts/Seravek-Bold.ttf

2) drag & drop into project & mark checkbox to include to app target

![NDHPF](https://user-images.githubusercontent.com/62171579/168812411-6c96ad58-272b-44dd-9735-2d5fd0ce6b35.png)

3) Registered font with Info.plist

![FnGlA](https://user-images.githubusercontent.com/62171579/168812453-cf50f03d-0581-4d60-88df-f27533de2ee6.png)


4) Demo content view

```
struct TestSeravekFont: View {
    var body: some View {
        Text("Hello, World! Specific Qij")
			.font(Font.custom("Seravek Bold", size: 40))
    }
}
```

5) Output

![Qu4dl](https://user-images.githubusercontent.com/62171579/168812487-62a22f08-b1c7-49d7-9f68-4b83b444e37b.png)

Here is how font looks in Font Manager, so we see that this is it. Done.

![ELLrI](https://user-images.githubusercontent.com/62171579/168812552-c1a77e54-6b9e-4698-aae8-c1994f8503a5.png)

