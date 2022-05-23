```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to make a non-observable class's methods available to SwiftUI views? (by SwiftEnthusiast)

A: A possible approach is to create manager as regular property, but inject view models as environment, like

```
struct ContentView: View {
    private var manager = Manager()

    var body: some View {
        SomeRootView()
           .environmentObject(manager.vm1)
           .environmentObject(manager.vm2)
    }
}
```

or in-place of each subview depending in which subview hierarchy corresponding view model is needed, like

```
struct ContentView: View {
    private var manager = Manager()

    var body: some View {
        ChildView1()
           .environmentObject(manager.vm1)
        // ... other code
        VStack {
          // ... other code
          ChildView2()
            .environmentObject(manager.vm2)
        }
    }
}
```

If manager is needed somewhere in deep child view, then it possible to transfer it there by injecting `Environment` value, 
like:

```
struct SomeYourView: View {
    @Environment(\.manager) var manager  // used default Manager

    var body: some View {
        ChildView()
            .environmentObject(manager.vm1)
    }
}

struct ManagerKey: EnvironmentKey {
    static let defaultValue: Manager = Manager()
}

extension EnvironmentValues {
    var manager: Manager {
        get { self[ManagerKey.self] }
        set { self[ManagerKey.self] = newValue }
    }
}
```

Or to make it singleton and use via `Manager.shared`, like

```
class Manager {
  static let shared = Manager()
}

struct SomeYourView: View {
    var body: some View {
        ChildView()
            .environmentObject(Manager.shared.vm1)
    }
}
```
