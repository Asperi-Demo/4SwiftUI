```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

A: SwiftUI | Using onDrag and onDrop to reorder Items within one single LazyGrid? (by Mofawaw)

Q: 
**SwiftUI 2.0**

Here is completed simple demo of possible approach (did not tune it much, `cause code growing fast as for demo). 

![Scamj](https://user-images.githubusercontent.com/62171579/162632145-9d884383-0e4d-4b3c-b104-cc7139457739.gif)


Important points are: a) reordering does not suppose waiting for drop, so should be tracked on the fly; b) to avoid dances with coordinates it is more simple to handle drop by grid item views; c) find what to where move and do this in data model, so SwiftUI animate views by itself.

Tested with Xcode 12b3 / iOS 14

```
import SwiftUI
import UniformTypeIdentifiers

struct GridData: Identifiable, Equatable {
    let id: Int
}

//MARK: - Model

class Model: ObservableObject {
    @Published var data: [GridData]

    let columns = [
        GridItem(.fixed(160)),
        GridItem(.fixed(160))
    ]

    init() {
        data = Array(repeating: GridData(id: 0), count: 100)
        for i in 0..<data.count {
            data[i] = GridData(id: i)
        }
    }
}

//MARK: - Grid

struct DemoDragRelocateView: View {
    @StateObject private var model = Model()

    @State private var dragging: GridData?

    var body: some View {
        ScrollView {
           LazyVGrid(columns: model.columns, spacing: 32) {
                ForEach(model.data) { d in
                    GridItemView(d: d)
                        .overlay(dragging?.id == d.id ? Color.white.opacity(0.8) : Color.clear)
                        .onDrag {
                            self.dragging = d
                            return NSItemProvider(object: String(d.id) as NSString)
                        }
                        .onDrop(of: [UTType.text], delegate: DragRelocateDelegate(item: d, listData: $model.data, current: $dragging))
                }
            }.animation(.default, value: model.data)
        }
    }
}

struct DragRelocateDelegate: DropDelegate {
    let item: GridData
    @Binding var listData: [GridData]
    @Binding var current: GridData?

    func dropEntered(info: DropInfo) {
        if item != current {
            let from = listData.firstIndex(of: current!)!
            let to = listData.firstIndex(of: item)!
            if listData[to].id != current!.id {
                listData.move(fromOffsets: IndexSet(integer: from),
                    toOffset: to > from ? to + 1 : to)
            }
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return true
    }
}

//MARK: - GridItem

struct GridItemView: View {
    var d: GridData

    var body: some View {
        VStack {
            Text(String(d.id))
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 160, height: 240)
        .background(Color.green)
    }
}
```

<h2>Edit</h2>

Here is how to fix the never disappearing drag item when dropped outside of any grid item:

```
struct DropOutsideDelegate: DropDelegate { 
    @Binding var current: GridData?  
        
    func performDrop(info: DropInfo) -> Bool {
        current = nil
        return true
    }
}
```
```
struct DemoDragRelocateView: View {
    ...

    var body: some View {
        ScrollView {
            ...
        }
        .onDrop(of: [UTType.text], delegate: DropOutsideDelegate(current: $dragging))
    }
}
```
