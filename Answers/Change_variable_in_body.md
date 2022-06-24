```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - Change View variable based on input parameter (by Peanutsmasher)

A: Here is possible approach

    struct TestView: View {
        
        let categorySize: ExampleEnum
        
        var body: some View {
            
            var size: CGFloat  = 92     // define local var
            if categorySize == .Large {
                size = 140
            } else if categorySize == .Small {
                size = 40
            }
            
            return Image(name: "TestImage")    // << return is required !!
                .resizable()
                .frame(width: size, height: size)
        }
    }

