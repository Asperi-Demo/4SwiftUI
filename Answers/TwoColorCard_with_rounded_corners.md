```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Mask a rectangle inside a rounded rectangle (by zardon)

A: If I correctly understood your goal, here is a solution - the only 
needed clip in right place is *after* internal content (two rectangles in 
this case) is constructed. So clipping with `RoundedRectangle` gives 
rounded corners around entire card. (As well as `shadow` most probably 
is needed to entire card, so placed at the end).

UPDATE: re-tested with Xcode 13.3 / iOS 15.4

![fahkA](https://user-images.githubusercontent.com/62171579/165592027-bfe4cfd9-3c5b-49ec-8104-fad9753232d8.png)


    ZStack (alignment: .topLeading) {
        Rectangle()
            .foregroundColor(.white)

        Rectangle()
            .fill(Color.pink)
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 150, alignment: .top)
    }
    .clipShape(RoundedRectangle(cornerRadius: 16))       // << here !!
    .frame(width: 300, height: 450, alignment: .center)
    .shadow(radius: 10)


