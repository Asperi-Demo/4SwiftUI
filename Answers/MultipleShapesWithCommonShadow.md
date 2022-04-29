```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to make multiple shapes with unified shadow? (by fuzzygoat)

A: Here is possible solution - join into zero spacing stack and combine with 
`compositionGroup`, and only after this apply `shadow`. 

Tested with Xcode 11.4 / iOS 13.4

![yrG80](https://user-images.githubusercontent.com/62171579/165960610-7e380f15-6ac7-47bb-8bcf-b33437dc3651.png)
![Eb5M4](https://user-images.githubusercontent.com/62171579/165960626-c4b60802-581c-4f6a-9119-8eca2704d0f8.png)


```
struct CardView: View {
    var body: some View {
        VStack(spacing: 0) {
            Circle()
                .trim(from: 0.5, to: 1)
                .fill(Color.orange)
                .frame(width: 100, height: 100)
                .offset(x: 0, y: 50)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.orange)
                .frame(width: 200, height: 250)
        }
        .compositingGroup()
        .shadow(color: Color.primary, radius: 10, x: 0, y: 0)
    }
}
```
