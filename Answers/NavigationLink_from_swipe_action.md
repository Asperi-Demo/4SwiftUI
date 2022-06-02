```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to use NavigationLink for List view swipe action (by Dawy)

A: It does not work because `swipeActions` context is out of `NavigationView`. Instead we can use same `NavigationLink` for conditional navigation, depending on action.

Here is a simplified demo of possible approach - make destination conditional and use programmatic activation of link.

Tested with Xcode 13.2 / iOS 15.2

![YcfT9](https://user-images.githubusercontent.com/62171579/171551894-f0b4e016-806c-4617-874c-7c4b765c3e3a.gif)


```
struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<2, id: \.id) {
                    // separate into standalone view for better
                    // state management
                    ProcessRowView(process: $0)
                }
            }
        }
    }
}

struct ProcessRowView: View {
  enum Action {
    case view
      case edit
    }
  @State private var isActive = false
  @State private var action: Action?
  let process: Int

    var body: some View {
        // by default navigate as-is
        NavigationLink("Item: \(process)", destination: destination, isActive: $isActive)
            .swipeActions() {
                Button("Delete") {

                }.tint(.red)
                Button("Edit") {
                  action = .edit    // specific action
                    isActive = true   // activate link programmatically
                }.tint(.blue)
            }
            .onChange(of: isActive) {
              if !$0 {
                 action = nil  // reset back
                }
            }
    }

  @ViewBuilder
    private var destination: some View {
        // construct destination depending on action
    if case .edit = action {
        Text("ProcessView")
        } else {
          // just to demo different type destinations
          Color.yellow.overlay(Text("MeasurementsView"))
        }
    }
}
```
