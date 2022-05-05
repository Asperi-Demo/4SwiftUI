```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: iOS 14 Medium Widget Size Background Image Refuses to Fill (by David Vincent Gagne)

A: Here is fixed variant - as image in the background you have to expand `VStack` to full screen. 

*Note: `edgesIgnoringSafeArea` allows to go beyond safe area when content is wider, but not make content wide.*

    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            Text("Aardvark Exactlywhat")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 20)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
                .shadow(
                    color: Color.black,
                    radius: 1.0,
                    x: CGFloat(4),
                    y: CGFloat(4))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)   // << this one !!
        .edgesIgnoringSafeArea(.all)
        .background(
            Image("plant")
                .resizable()
                .scaledToFill()
        )
    }
