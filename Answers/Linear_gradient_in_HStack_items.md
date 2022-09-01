>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Linear Color Gradient to items in HStack? (by fuzzygoat)

A: There is built-in Gradient... how to present it is up to us... Here is a demo of possible approach, but it is just ... one of many other variants.

![0YReF](https://user-images.githubusercontent.com/62171579/187991262-753f3710-1d19-4d61-bcaf-21b4fb8d2d50.png)


```
struct GradView: View {
    var body: some View {
        HStack(spacing: 0) {
            ForEach((1...7).reversed(), id: \.self) { index in
                HStack(spacing: 0) {
                    Rectangle().fill(Color.clear)
                        .frame(width: 50, height: 50)
                    Rectangle().fill(Color(UIColor.systemBackground))
                        .frame(width: 4, height: 50)
                }
            }
        }.background(LinearGradient(gradient: 
           Gradient(colors:[.red, .black]), 
                    startPoint: .leading, endPoint: .trailing))
    }
}
```
