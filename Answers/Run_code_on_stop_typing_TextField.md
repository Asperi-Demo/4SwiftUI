```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: How to only run code when the user stops typing in a TextField? (by nickcoding)

A: The possible approach is to use `debounce` from Combine framework. To use that it is better to create separated view model with published property for search text.

Here is a demo. Prepared & tested with Xcode 12.4 / iOS 14.4.

```
import Combine

class SearchBarViewModel: ObservableObject {
    @Published var text: String = ""
}

struct SearchBarView: View {
    @StateObject private var vm = SearchBarViewModel()
    var body: some View {
        ZStack {
            TextField("Search", text: $vm.text)
                .onReceive(
                    vm.$text
                        .debounce(for: .seconds(2), scheduler: DispatchQueue.main)
                ) {
                    guard !$0.isEmpty else { return }
                    print(">> searching for: \($0)")
                }
        }
    }
}
```
