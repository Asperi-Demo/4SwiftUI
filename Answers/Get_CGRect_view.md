```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Get CGRect of View (by Peter Warbo)

A: Update: improved and simplified a possible solution to read rect of any view in any coordinate space via helper extension. Works since Xcode 11.1, retested with Xcode 13.3.

```
public extension View {
	// Get rect of a view in specified coordinate space, by default in global, so by default it
	// provides view's frame in window coordinates, to have bounds specify .local, to have in some
	// parent provide named coordinate space correspondingly.
	func reading(rect binding: Binding<CGRect>, _ space: CoordinateSpace = .global) -> some View {
		self.background(rectReader(binding, space))
	}
}

func rectReader(_ binding: Binding<CGRect>, _ space: CoordinateSpace = .global) -> some View {
    GeometryReader { (geometry) -> Color in
        let rect = geometry.frame(in: space)
        DispatchQueue.main.async {
            binding.wrappedValue = rect
        }
        return .clear
    }
}
```

Usage the same

    Text("Test").background(rectReader($rect))

or with new extension

    Text("Test").reading(rect: $rect)

[Code in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Extensions/View%2B.swift)
