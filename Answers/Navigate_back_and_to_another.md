```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to navigate back and to another view? (by DarkByte)

A: Here is a demo of possible solution. Prepared and tested with Xcode 12.4 / iOS 14.4.

The idea is to control navigation at the root view side, because changes in NavigationView internal state seems confused by moment of modification.

![sqZab](https://user-images.githubusercontent.com/62171579/176403826-9a8398ed-0514-42c9-b762-9afb23b93c3f.gif)

```
class NavRouteModel: ObservableObject {
    @Published var currentTag: Int?
}

struct TestNavigationTriangle: View {
    @StateObject private var vm = NavRouteModel()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("ViewB", destination: ViewB {
                    self.vm.currentTag = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.vm.currentTag = 2
                    }
                }, tag: 1, selection: $vm.currentTag)
                NavigationLink("ViewC", destination: Text("ViewC"), tag: 2, selection: $vm.currentTag)
            }
        }
    }
}

struct ViewB: View {
    var completed: () -> () = {}
    
    var body: some View {
        Button("Complete & Go to ViewC", action: completed)
    }
}
```
