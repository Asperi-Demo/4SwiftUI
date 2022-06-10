```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Multiline label for SwiftUI Picker SegmentedPickerStyle (by Lumentus)

A: System controls are only default controls - we can always implement our own with whichever parameters we need.

Here is simplified demo of how to implement custom picker with any cell content needed.

*Note: all constants and parameters can be separated into standalone configuration struct to be used as style, etc.*

Used Xcode 13.2 / iOS 15.2

![gAliP](https://user-images.githubusercontent.com/62171579/173116403-1e691306-022c-47f3-a753-9f317b14cdee.gif)

```
struct TestMyPicker: View {

  @State private var selection: Int?
  let data = [1, 2, 3, 4]
  var body: some View {
    MyPicker(data: data, selection: $selection) { item in
      VStack {
       Text("H\(item)")
         Text("Sub \(item)")
      }.padding(.horizontal, 12)
    }
  }
}

extension Int: Identifiable {    // just for testing purpose
  public var id: Int { self }
}


struct MyPicker<Cell, Data>: View where Cell: View, Data: RandomAccessCollection, Data.Element: Identifiable {
  let data: Data
  @Binding var selection: Data.Element?
  @ViewBuilder let cell: (Data.Element) -> Cell
  @Namespace private var ns

  var body: some View {
  HStack(spacing: 0) {
    ForEach(data) { item in
       cell(item)
        .foregroundColor(.white)
        .padding(.horizontal, 8)
         .overlay(
           Group {
              if selection?.id == item.id {
                RoundedRectangle(cornerRadius: 8).fill(Color.white)
                  .opacity(0.2)
                  .matchedGeometryEffect(id: "Marker", in: ns)
              }
            }
          )
          .onTapGesture {
            if selection?.id == item.id {
             selection = nil
            } else {
              selection = item
            }
          }
      }
    }
    .animation(.linear(duration: 0.25), value: selection?.id)
    .fixedSize(horizontal: false, vertical: true)
    .padding(2)
    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray))
  }
}
```
