Q: How to make multiple shapes with unified shadow? (by fuzzygoat)

A: Here is possible solution. Tested with Xcode 11.4 / iOS 13.4



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
