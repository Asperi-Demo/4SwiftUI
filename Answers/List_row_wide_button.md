```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Custom Button in SwiftUI List (by Peter Davison-Reiber)

A: In standard variant List intercepts and handles content area of tap detection, 
in usual custom style it is defined, by default, by opaque area, which is only text
in usual case, so corrected style as provided below with additional fixes for 
different iOS versions.

![gb6l9](https://user-images.githubusercontent.com/62171579/164988365-402a184d-9062-4d2b-81c0-f5c4d5f25f90.gif)

## Update for: Xcode 13.3 / iOS 15.4 ##

It looks like Apple broken something, because `listRowBackground` now works **only** 
inside `List` itself, no subview, which is senseless from generic concept of SwiftUI.

Anyway, here are needed changes to original solution to have same effect as on demo:
1) replace `GroupedListStyle` with `InsetGroupedListStyle` list style, or remove `.listStyle` 
modifier at all, because now last is default one.
2) replace `listRowBackground` in `BlueButtonStyle` with `background` having same arguments
3) add row inset after button style, like
```
	.buttonStyle(BlueButtonStyle())
	.listRowInsets(EdgeInsets())      // << here !!
```

## Original for: Xcode 11.4 / iOS 13.4 ##

```
struct BlueButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
        .font(.headline)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .contentShape(Rectangle())
        .foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : Color.white)
        .listRowBackground(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
  }
}
```

and usage, just 

    Button(action: {print("pressed")})
    {
        Text("Save")
    }.buttonStyle(BlueButtonStyle())

and even

    Button("Save") { print("pressed") }
        .buttonStyle(BlueButtonStyle())

[Tested module in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestCustomButtonInList.swift)
