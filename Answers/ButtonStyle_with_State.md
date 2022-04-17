Q: Is there a way for a button background color to remain changed after being selected?

A: We can do that by introducing state in button style and make style changes dependent on it, while updating state conditionally when needed.

Here is main part of approach (tested with Xcode 13.3 / iOS 15.4)

![ezgif com-gif-maker-37](https://user-images.githubusercontent.com/62171579/163703490-b1503034-e07d-4526-93bb-0bc91a2099fa.gif)


```
struct TestFixedStateButtonStyle: View {
  var body: some View {
    Button("Demo") {}
      .buttonStyle(MyButtonStyle())
  }

  struct MyButtonStyle: ButtonStyle {
    @State private var flag = false
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .padding()
        .foregroundColor(flag ? Color.white : Color.green)
        .background(flag ? Color.red : Color.clear)
        .onChange(of: configuration.isPressed) {
          if $0 {
            flag.toggle()
          }
        }
    }
  }

}
```
