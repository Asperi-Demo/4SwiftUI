```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Get light or dark variant of a color declared in assets (by Arek)

A: In SwiftUI if there is need to use light variant for some subview it is enough to force specify `.colorScheme` for it, like below

Color variants:

![fZR5h](https://user-images.githubusercontent.com/62171579/168629832-0cec9f84-f7ab-4f40-86eb-6705a74a619e.png)

Demo:

![sWSNZ](https://user-images.githubusercontent.com/62171579/168629901-74e475ed-f7b3-4394-8823-e218da58fb55.png)

    var body: some View {
        VStack {
            Rectangle().fill(Color("testColor"))
                .frame(width: 100, height: 100)
                .environment(\.colorScheme, .light) // << force light
        }
        .frame(width: 300, height: 300)
        .background(Color("testColor")) // << system appearance
    }
