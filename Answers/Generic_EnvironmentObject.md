```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to create Generic if @EnvironmentObject? (by punkbit)

A: The EnvironmentObject must be ObservableObject, so here is fix

```
struct ContentView<T: ObservableObject>: View {
    @EnvironmentObject var mockFoobar: T
    
    // .. other code here
```

**Update:** added demo with introduced model protocol

```
protocol Foobaring {
    var param: Bool { get set }
    func start()
}

class Foobar: ObservableObject, Foobaring {
    @Published var param: Bool = false
    func start() {
        self.param = true
    }
}

struct MyFoobarView<T: ObservableObject & Foobaring>: View {
    @EnvironmentObject var foobar: T

    var body: some View {
        VStack {
            Text("Hello Foobar")
        }
        .onAppear {
            self.foobar.start()
        }
    }
}

struct MyFoobarView_Previews: PreviewProvider {
    static var previews: some View {
        let foobar: Foobar = Foobar()
        return MyFoobarView<Foobar>()
            .environmentObject(foobar)
    }
}
```
