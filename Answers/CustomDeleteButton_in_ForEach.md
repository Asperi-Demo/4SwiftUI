```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to create a custom delete button without using the slide to delete that 
comes with swiftUI I am not using list, just using a foreach loop? (by ItsZiaW)

A: Here is a simple demo of possible approach to implement custom 
delete (of course with move it would be more complicated due to drag/drop, 
but idea is the same). Tested with Xcode 12 / iOS 14.

![MTWIG](https://user-images.githubusercontent.com/62171579/165327574-b638f8ae-9a5c-4b4e-92a5-d379672d1ed5.gif)

```
struct DemoCustomDelete: View {
    @State private var numbers = [0,1,2,3,4,5,6,7,8,9]
    var body: some View {
        NavigationView {
            VStack (spacing: 10) {
                ForEach(numbers, id: \.self) { number in
                    VStack {
                        Text("\(number)")
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.red)
                    .overlay(
                        DeleteButton(number: number, numbers: $numbers, onDelete: removeRows)
                    , alignment: .topTrailing)
                }.onDelete(perform: removeRows)
            }
            .navigationTitle("Trying")
            .navigationBarItems(trailing: EditButton())
        }
    }

    func removeRows(at offsets: IndexSet) {
        withAnimation {
            numbers.remove(atOffsets: offsets)
        }
    }
}

struct DeleteButton: View {
    @Environment(\.editMode) var editMode

    let number: Int
    @Binding var numbers: [Int]
    let onDelete: (IndexSet) -> ()

    var body: some View {
        VStack {
            if self.editMode?.wrappedValue == .active {
                Button(action: {
                    if let index = numbers.firstIndex(of: number) {
                        self.onDelete(IndexSet(integer: index))
                    }
                }) {
                    Image(systemName: "minus.circle")
                }
                .offset(x: 10, y: -10)
            }
        }
    }
}
```
