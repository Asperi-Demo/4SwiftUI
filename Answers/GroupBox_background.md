```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Change GroupBox background color in SwiftUI (by JacobF)

A: Applying background directly to GroupBox does not work, this is default group 
box style. We can create whatever group box needed using custom style.

Here is an example. Tested with Xcode 12 / iOS 14.

![h5pQz-2](https://user-images.githubusercontent.com/62171579/166867142-c841aa25-79c2-4ee7-ab95-4fbf52c0dbd5.png)

```
struct DemoGroupBox: View {
  var body: some View {
    GroupBox(label: Text("Label"), content: {
       Text("Content")
    })
    .groupBoxStyle(TransparentGroupBox())
    .padding()
  }
}

struct TransparentGroupBox: GroupBoxStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.content
      .frame(maxWidth: .infinity)
      .padding()
      .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
      .overlay(configuration.label.padding(.leading, 4), alignment: .topLeading)
  }
}
```

