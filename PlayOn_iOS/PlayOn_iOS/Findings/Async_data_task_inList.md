```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: VStack messes with task modifier? (by MichaelBobu19)

A: The solution appears to be platform dependent.

## for macOS ##

It looks like it is macOS List bug. One alternate is to use `ScrollView+LazyVStack` instead of List, which works w/o any other changes in code or logic. Another alternate is to move async fetching data logic into view model and leave view update just on main actor.

Tested with Xcode 13.3 / macOS 12.2

![ezgif com-gif-maker-50](https://user-images.githubusercontent.com/62171579/166635737-7623e28f-55dd-4523-87e4-fe1ee4c8cb84.gif)

```
struct AsyncDataView: View {
    @StateObject private var vm = ViewModel()

    class ViewModel: ObservableObject {
      @Published var data: String?

      init() {
        update()
      }

      func update() {
        Task.detached {
          try? await Task.sleep(nanoseconds: 1_000_000_000)

          await MainActor.run {
            self.data = String(Int.random(in: 0..<100))
          }
        }
      }
    }

    var body: some View {
        if let data = vm.data {
            Text(data)
        }
        else {
            ProgressView()
        }
    }
}
```

## for iOS ##

The fix is simple - wrap builder in stack:

```
  @ViewBuilder private var mainBody: some View {
    VStack {                  // << here !!
      if let data = data {
        Text(data)
      }
      else {
        ProgressView()
      }
    }
        // actually .task will be connected here !!
  }
```

Tested with Xcode 13.3 / iOS 15.4

[Test code in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_macOS/PlayOn_macOS/Findings/TestAsyncProgressInList.swift)
