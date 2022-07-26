```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI ViewModifier for custom View

A: It is your view and modifiers are just functions that generate another, 
modified, view, so... here is some possible simple way to achieve what you want.

Tested with Xcode 12 / iOS 14

![gUqvi](https://user-images.githubusercontent.com/62171579/167466551-36774cbc-f2fb-41b2-8ae0-502ba458385d.png)

```
struct ChildView: View {
    var theText = ""
    
    @State private var color = Color(.purple)
    
    var body: some View {
        HStack {
            if theText.isEmpty {          // If there's no theText, a Circle is created
                Circle()
                    .foregroundColor(color)
                    .frame(width: 100, height: 100)
            } else {                      // If theText is provided, a Text is created
                Text(theText)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(color))
                    .foregroundColor(.white)
            }
        }
    }
    
    // simply modify self, as self is just a value
    public func someModifierOrTheLike(color: Color) -> some View {
		var view = self
		view._color = State(initialValue: color)
		return view.id(UUID())
	}
}

struct SomeOtherParentView: View {
    var body: some View {
        HStack(spacing: 20) {
            ChildView()

            ChildView(theText: "Hello world!")
                .someModifierOrTheLike(color: Color.green)   // <- intention to use 
        }
    }
}
```
