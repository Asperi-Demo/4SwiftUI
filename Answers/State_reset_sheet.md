```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Why does state reset to nil after assignment (by Developer-1)

A: The issue is due to sheet is created before button clicked. The solution for your scenario is to use `.sheet(item:` approach.

Here is corrected code. Tested with Xcode 12.1 / iOS 14.1

```
struct ContentView: View {
    
    class Object: Identifiable {
        let id: String
        init(_ id: String) { self.id = id }
    }
    
    let collection = [Object("1"),Object("2"),Object("3")]
    
    @State var state: Object?
    
    var body: some View {
        
        List(collection) { item in
            
            HStack{ Text(item.id); Spacer() }
                .background(Color.white)
                .onTapGesture(count:1, perform: {
                    self.state = item
            })
        }
        .sheet(item: $state) { item in
				 Text(item.id)
        }
    }
}
```
