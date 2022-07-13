```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Transition not happening when data in model is being removed and added in swiftUi (by sriram hegde)

A: Here is a possible solution. (*Note: your `dataArray` have to contain unique values, otherwise you should find a way to make them uniquely identified*)

Tested with Xcode 12 / iOS 14

![1JMCT](https://user-images.githubusercontent.com/62171579/178668921-2c63cc0d-d14b-44c9-9f41-58a1b51ab89a.gif)

```
struct ContentView: View {

    @ObservedObject var viewModel = ViewModelTest()
    @State private var isLoading = false

    var body: some View {

        VStack {
            HStack {
                ForEach(viewModel.model.dataArray, id: \.self) { _ in
                    if self.isLoading {
                        Color.red
                            .frame(width: 100, height: 170)
                            .transition(.scale)
                    }
                }
            }
            .animation(.easeInOut(duration: 1))
            .onAppear {
                self.isLoading = true
            }

            HStack {
                Button(action: {
                    self.viewModel.addToArray()
                }) {
                    Text("add")
                }

                Button(action: {
                    self.viewModel.removeFromArray()
                }) {
                    Text("remove")
                }
            }
        }
    }
}
```

**Update:** for SwiftUI 1.0 use the following (tested with Xcode 11.4 / iOS 13.4)

    ForEach(viewModel.model.dataArray, id: \.self) { _ in
        Group {
          if self.isLoading {
            Color.red
                .frame(width: 100, height: 170)
                .transition(.scale)
        }}
    }

