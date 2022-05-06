Q: How to change toggle on just one Core Data item using ForEach in SwiftUI? (by mallow)

A: Instead of trying to use one state per CoreData item in ForEach that could result in binding all `Toggle` 
controls to *one* state... so 

1) remove this

```
//    @State private var doneStatus : Bool = false
```

2) bind `Toggle` dynamically to currently iterating `item` (in this case .onAppear/.onTapGesture needed anymore)

```
Toggle(isOn: Binding<Bool>(
    get: { item.done },
    set: {
        item.done = $0
        try? self.moc.save()
    })) {
    Text()
}
.labelsHidden()
```
