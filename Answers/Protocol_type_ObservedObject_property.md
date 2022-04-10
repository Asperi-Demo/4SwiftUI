```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

A: How to define a protocol as a type for a @ObservedObject property? (by M.Serag)

Q: Wrappers and stored properties are not allowed in swift protocols and extensions, at least for now. So I would go with the following approach mixing protocols, generics and classes... (all compilable and tested with Xcode 11.2 / iOS 13.2)


    // base model protocol
    protocol ItemViewModel: ObservableObject {
        var title: String { get set }
    
        func save()
        func delete()
    }
    
    // generic view based on protocol
    struct ItemView<Model>: View where Model: ItemViewModel {
        @ObservedObject var viewModel: Model
    
        var body: some View {
            VStack {
                TextField("Item Title", text: $viewModel.title)
                Button("Save") { self.viewModel.save() }
            }
        }
    }
    
    // extension with default implementations
    extension ItemViewModel {
        
        var title: String {
            get { "Some default Title" }
            set { }
        }
        
        func save() {
            // some default behaviour
        }
    
        func delete() {
            // some default behaviour
        }
    }
    
    // concrete implementor
    class SomeItemModel: ItemViewModel {
        @Published var title: String
        
        init(_ title: String) {
            self.title = title
        }
    }
    
    // testing view
    struct TestItemView: View {
        var body: some View {
            ItemView(viewModel: SomeItemModel("test"))
        }
    }

