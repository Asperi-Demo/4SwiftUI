```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to dismiss a presenting view to the root view of tab view in SwiftUI? (by Aldo Sugiarto)

A: The `presentationMode` is one-level effect value, ie changing it you close one currently presented screen.

Thus to close many presented screens you have to implement this programmatically, like in demo below.

The possible approach is to use custom `EnvironmentKey` to pass it down view hierarchy w/o tight coupling of every level view (like with binding) and inject/call only at that level where needed.

Demo tested with Xcode 12.4 / iOS 14.4

![jVqi6](https://user-images.githubusercontent.com/62171579/171702826-9b0814f7-59e2-4f8a-bdba-77fb96c47e9b.gif)

```
struct ContentView: View {
    var body: some View {
        TabView {
          Text("Tab1")
            .tabItem { Image(systemName: "1.square") }
          Tab2RootView()
            .tabItem { Image(systemName: "2.square") }
    }
    }
}

struct Tab2RootView: View {
  @State var toRoot = false
  var body: some View {
    NavigationView {
      Tab2NoteView(level: 0)
        .id(toRoot)          // << reset to root !!
    }
    .environment(\.rewind, $toRoot)        // << inject here !!
  }
}

struct Tab2NoteView: View {
  @Environment(\.rewind) var rewind
  let level: Int

  @State private var showFullScreen = false
  var body: some View {
    VStack {
      Text(level == 0 ? "ROOT" : "Level \(level)")
      NavigationLink("Go Next", destination: Tab2NoteView(level: level + 1))
      Divider()
      Button("Full Screen") { showFullScreen.toggle() }
        .fullScreenCover(isPresented: $showFullScreen,
                    onDismiss: { rewind.wrappedValue.toggle() }) {
          Tab2FullScreenView()
        }
    }
  }
}

struct RewindKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var rewind: Binding<Bool> {
        get { self[RewindKey.self] }
        set { self[RewindKey.self] = newValue }
    }
}

struct Tab2FullScreenView: View {
  @Environment(\.presentationMode) var mode

  var body: some View {
    Button("Close") { mode.wrappedValue.dismiss() }
  }
}
```
