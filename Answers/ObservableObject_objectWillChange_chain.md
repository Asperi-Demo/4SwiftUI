```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Passing an ObservableObject model through another ObObject? (by Sparklebeard)

A: `ObsesrvedObject` listens for changes in `@Published` property, but not the deeper internal publishers, so the below idea is to join internal publisher, which is `PassthroughSubject`, with `@Published var settings`, to indicate that the latter has updated.

> Tested with Xcode 11.2 / iOS 13.2

The only needed changes is in `ViewModel`...

    class ViewModel: ObservableObject {
    
        @Published var title = "Initial Title"
        @Published var settings = UserSettings()
    
        private var cancellables = Set<AnyCancellable>()
        init() {
            self.settings.objectWillChange
                .sink { _ in
                    self.objectWillChange.send()
                }
                .store(in: &cancellables)
        }
    }

