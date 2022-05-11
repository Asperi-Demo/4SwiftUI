```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Position view relative to a another centered view (by Jul)

A: Here is possible solution - use spacers at both sides and place text into overlay of those 
spacers. As alternate, depending on context or others views layout, it might be used
Color.clear instead of Spacer. 

Tested with Xcode 11.4 / iOS 13.4


A view for List row

```
struct DemoCenteredNumberView: View {
    var value: Int
    var body: some View {
        HStack {
            Spacer().overlay(
                Text("Text on left side")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            )
            Text("\(value)").padding()
            Spacer().overlay(
                Text("Text on right")
                    .frame(maxWidth: .infinity, alignment: .leading)
            )
        }
    }
}
```
