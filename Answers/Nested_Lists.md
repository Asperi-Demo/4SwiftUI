```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - nested Lists (by Mane Manero)

A: Why do you think it should be List in List... Such visual representation can be generated using only one list and it will have native look & feel.

Here is just a demo (w/o UI tuning and logic of showing/hiding sections, that is out of topic), but the idea should be clear

![ieGk2](https://user-images.githubusercontent.com/62171579/166864054-96054294-a898-4712-bb9a-cb0ea97470e8.png)


    struct ItemRow: View {
        let category: Bool
        let text: String
        
        init(_ text: String, isCategory: Bool = false) {
            self.category = isCategory
            self.text = text
        }
        
        var body: some View {
            HStack {
                Circle().stroke() // this can be custom control
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        // handle tap here
                    }
                if category {
                    Text(self.text).bold()
                } else {
                    Text(self.text)
                }
            }
        }
    }
    
    struct TestNestedLists: View {
        var body: some View {
            List { // next pattern easily wrapped with ForEach
                ItemRow("Category", isCategory: true) // this can be section's header
                Section {
                    ItemRow("Item 1")
                    ItemRow("Item 2")
                    ItemRow("Item 3")
                }.padding(.leading, 20)
            }
        }
    }
    
