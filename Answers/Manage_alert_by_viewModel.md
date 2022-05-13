```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Presenting an Alert in SwiftUI using MVVM (by Anton)

```
enum Status {
    case idle
    case computing
    case newResultAvailable
}
```

A: Here is possible approach - use computable Binding as a proxy
to activate alert on specific status and reset it back on alert's
action.

Tested & works with Xcode 11.3+

    struct ContentView: View {
    
        @ObservedObject var vm = MyViewModel()
    
        var body: some View {
            let announcingResult = Binding<Bool>(
                get: { self.vm.status == .newResultAvailable },
                set: { _ in self.vm.status = .idle }
            )
            return Text("Hello")
                .alert(isPresented: announcingResult) {
                    Alert(title: Text("There's a new result!"),
                        message: nil,
                        dismissButton: .default(Text("OK")))
                }
        }
    }

also sometimes the following notation can be preferable

    var body: some View {
        Text("Hello")
            .alert(isPresented: Binding<Bool>(
                get: { self.vm.status == .newResultAvailable },
                set: { _ in self.vm.status = .idle }
            )) {
                Alert(title: Text("There's a new result!"),
                    message: nil,
                    dismissButton: .default(Text("OK")))
            }
    }
