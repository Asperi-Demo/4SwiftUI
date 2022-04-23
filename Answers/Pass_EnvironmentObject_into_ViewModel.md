```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - How to pass EnvironmentObject into View Model? (by Michael)

A: Here is a possible approach. Tested with many solutions started with Xcode 11.1.

The problem originated from the way EnvironmentObject is injected in view, general schema 

    SomeView().environmentObject(SomeEO())

ie, at first - created view, at second created environment object, at third environment object injected into view

Thus if I need to create/setup view model in view constructor the environment object is not present there yet.

Solution: break everything apart and use explicit dependency injection

Here is how it looks in code (generic schema)

```swift
// somewhere, say, in SceneDelegate

let someEO = SomeEO()                            // create environment object
let someVM = SomeVM(eo: someEO)                  // create view model
let someView = SomeView(vm: someVM)              // create view 
                   .environmentObject(someEO)
```

There is no any trade-off here, because ViewModel and EnvironmentObject are, by design, reference-types (actually, `ObservableObject`), so I pass here and there only references (aka pointers).

```
class SomeEO: ObservableObject {
}

class BaseVM: ObservableObject {
    let eo: SomeEO
    init(eo: SomeEO) {
       self.eo = eo
    }
}

class SomeVM: BaseVM {
}

class ChildVM: BaseVM {
}

struct SomeView: View {
    @EnvironmentObject var eo: SomeEO
    @ObservedObject var vm: SomeVM

    init(vm: SomeVM) {
       self.vm = vm
    }

    var body: some View {
        // environment object will be injected automatically if declared inside ChildView
        ChildView(vm: ChildVM(eo: self.eo)) 
    }
}

struct ChildView: View {
    @EnvironmentObject var eo: SomeEO
    @ObservedObject var vm: ChildVM

    init(vm: ChildVM) {
       self.vm = vm
    }

    var body: some View {
        Text("Just demo stub")
    }
}
```
