```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Deletable Table with TextField on SwiftUI (by yutailang0119)

A: Ok, the reason is in documentation for used ForEach constructor (as you see range is constant, so ForEach grabs initial range and holds it):

    /// Creates an instance that computes views on demand over a *constant*
    /// range.
    ///
    /// This instance only reads the initial value of `data` and so it does not
    /// need to identify views across updates.
    ///
    /// To compute views on demand over a dynamic range use
    /// `ForEach(_:id:content:)`.
    public init(_ data: Range<Int>, @ViewBuilder content: @escaping (Int) -> Content)


So the solution would be to provide dynamic container. Below you can find a demo of possible approach.

**Full module code**

    import SwiftUI
    
    struct DummyView: View {
        @State var animals: [String] = ["🐶", "🐱"]
    
        var body: some View {
            VStack {
                HStack {
                    EditButton()
                    Button(action: { self.animals.append("Animal \(self.animals.count + 1)") }, label: {Text("Add")})
                }
                List {
                    ForEach(animals, id: \.self) { item in
                        EditorView(container: self.$animals, index: self.animals.firstIndex(of: item)!, text: item)
                    }
                    .onDelete { indexSet in
                        self.animals.remove(atOffsets: indexSet) // Delete "🐶" from animals
                    }
                }
            }
        }
    }
    
    struct EditorView : View {
        var container: Binding<[String]>
        var index: Int
    
        @State var text: String
    
        var body: some View {
            TextField("", text: self.$text, onCommit: {
                self.container.wrappedValue[self.index] = self.text
            })
        }
    }
    
