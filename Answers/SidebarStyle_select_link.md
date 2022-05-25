```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: Select NavigationLink in a NavigationView / List with SidebarListStyle (by ixany)

A: Here is possible approach. The idea is to programmatically activate navigation link via view model, but separate model-level selection and presentation (own by link) selection.

Tested with Xcode 12b3 / iOS+iPadOS 14.

```swift
class SelectionViewModel: ObservableObject {
    var currentRow: Int = -1 {
        didSet {
            self.selection = currentRow
        }
    }

    @Published var selection: Int? = nil
}

struct SidebarContentView: View {
@StateObject var vm = SelectionViewModel()
private let listItems = [ListItem(), ListItem(), ListItem()]

var body: some View {
    NavigationView {

        List(listItems.indices) {
            index in

            let item = listItems[index]
            let isSelected = vm.currentRow == index

            Button("\(item.name) \(index) \(isSelected ? "selected" : "")") { vm.currentRow = index }
            .background (
                NavigationLink(destination: Text("Destination \(index) selected: \(vm.currentRow)"),
                               tag: index,
                               selection: $vm.selection) {
                    EmptyView()
                }.hidden()
            )
        }

    }
    .listStyle(SidebarListStyle())
    .onAppear(perform: {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            vm.currentRow = 2
        })
    })
    }
}
```
