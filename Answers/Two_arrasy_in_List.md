```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Iterate over two arrays simultaneously in List (by AlbertB)

A: A bit simpler

    var body: some View {
        VStack {
            List(Array(zip(colors, names)), id: \.self.0) { (color, name) in
                Text("\(color) - \(name)")
            }
        }
    }


**Update: added variant for non-equal-size arrays**

This one of course is a bit complicated, but might be helpful

    var body: some View {
        VStack {
            ListOfPairs()
        }
    }
    
    private func ListOfPairs() -> some View {
        var iter = names.makeIterator()
        let container = colors.reduce(into: Array<(String,String)>()) { (result, color) in
            result.append((color, iter.next() ?? "None" )) // << placeholder for empty
        }
        
        return List(container, id: \.self.0) { (color, name) in
            Text("\(color) - \(name)")
        }
    }

