```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to give shadow with cornerRadius to a Button in SwiftUI (by Mahendra)

A: I would do it like this

*Note*: the last .padding is not important, depending on where and how the button will be placed, here is just for demo.

![Kc0Tc](https://user-images.githubusercontent.com/62171579/163668511-adfc9f62-e704-4054-8fc2-707607e9c7d5.png)


    Button(action: {
    
    }) {
        Text("SIGN IN")
            .font(.system(size: 17))
            .fontWeight(.bold)
            .foregroundColor(.green)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
        )
        .padding()
    }


