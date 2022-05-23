```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Mutable Binding in SwiftUI Live Preview (by mallow)

A: Updates to a `@State` variable in a `PreviewProvider` appear to not update the 
the read-only computed property `previews` directly. The solution is to wrap 
the `@State` variable in a test holder view. Then use this test view inside 
the `previews` property so the Live Preview refreshes correctly. 

Tested in Xcode 11.2.1.


    struct ChildView: View {
        @Binding var itemName: String
    
        var body: some View {
            VStack {
                Text("Name: \(itemName)")
                Button(action: {
                    self.itemName = "different value"
                }) {
                    Text("Change")
                }
            }
        }
    }
    
    struct ChildView_Previews: PreviewProvider {
    
        struct BindingTestHolder: View {
            @State var testItem: String = "Initial"
            var body: some View {
                ChildView(itemName: $testItem)
            }
        }
    
        static var previews: some View {
            BindingTestHolder()
        }
    }

