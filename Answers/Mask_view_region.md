>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How to mask out a region of a view (by nppatt)

A: Here is possible approach:

![Q5FME](https://user-images.githubusercontent.com/62171579/181810814-fa3f6245-3ed6-4580-8d55-d357f5e71649.png)

    ZStack {
    
        Rectangle().frame(height: 60.0, alignment: .bottom)
            .foregroundColor(Color.blue)
            .offset(x: 0.0, y: 50.0)
        RoundedRectangle(cornerRadius: 25, style: .continuous)
            .stroke(lineWidth: 2.0)
            .fill(Color.red)
    }
    .mask(RoundedRectangle(cornerRadius: 25, style: .continuous).fill(Color.black))


