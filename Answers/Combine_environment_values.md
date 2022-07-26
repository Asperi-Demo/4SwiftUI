```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Combining environment variables into one in SwiftUI (by Phantom59)

A: A possible approach is to have own environment value and set at the very root level of your content view, so all other subviews will have it update on changes at root level, like

```
struct ContentView: View {
	  @Environment(\.horizontalSizeClass) var horizontalSizeClass
	  @Environment(\.sizeCategory) var sizeCategory

    var body: some View {
    	VStack {    // some top-most container or root view

	        // ... all app hierarchy 

        }
		.environment(\.isHorCompactLayout, horizontalSizeClass == .compact || sizeCategory.isAccessibilityCategory)
    }
}

struct HorCompactLayoutKey: EnvironmentKey {
	static let defaultValue: Bool = false
}

extension EnvironmentValues {
	var isHorCompactLayout: Bool {
		get { self[HorCompactLayoutKey.self] }
		set { self[HorCompactLayoutKey.self] = newValue }
	}
}
```

Tested with Xcode 13.4
