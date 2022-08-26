>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Prevent last rows in List to be covered by other view in ZStack (by cbuchart)

A: The possible solution is to calculate height of overlay area and add some transparent view with that height to the bottom of the list.

Here is a demo of approach using view preferences. Tested with Xcode 12 / iOS 14

![0LEAK](https://user-images.githubusercontent.com/62171579/186926974-024a55a8-03f7-4c7a-9510-f3013c4ac02e.gif)

```
struct ListWithBottomOverlay: View {
  @State private var height = CGFloat.zero
  var body: some View {
    GeometryReader { proxy in
      ZStack {
        List {
          ForEach(1..<20) { number in
            Text("\(number)")
          }
          Color.clear.frame(height: height)  // injected empty space
        }

        VStack {
          Spacer().frame(maxHeight: .infinity)

          VStack {
            HStack {
              Button(action: {}, label: { Text("Hello") })
                .frame(minHeight: 100)
            }
            HStack {
              Button(action: {}, label: { Text("World!") })
                .frame(minHeight: 100)
            }
          }
          .frame(maxWidth: .infinity)
          .background(GeometryReader {
                // use color filled area in background to read covered frame
                Color(.yellow).opacity(0.8)
                    .edgesIgnoringSafeArea(.bottom)
                    .preference(key: ViewHeightKey.self, value: $0.frame(in: .local).size.height)
            })
        }
      }
      .onPreferenceChange(ViewHeightKey.self) {
        // view preferences transferred in one rendering cycle and
        // give possibility to update state
        self.height = $0
      }
    }
  }
}

struct ViewHeightKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

```
