>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI get rid of AnyView for environment variables (by Manu)

A: Actually it is not needed to pass view via `Environment` (and it is not very appropriate tool for that) - 
we can hide everything within a private implementation of `NavigationStackView` and use it directly, like

```
struct NavigationStackView<Content: View>: View {
    private var content: () -> Content

	init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content
    }

	private struct _NavigationStackView<Content: View, Toolbar: View>: View {
	    private var content: () -> Content
	    private var toolbar: () -> Toolbar

        init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder toolbar: @escaping () -> Toolbar) {
			self.content = content
   			self.toolbar = toolbar
        }

        var body: some View {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    toolbar()
                }
                Spacer()
                content()
                Spacer()
            }
        }
	}

	var body: some View {
		_NavigationStackView(content: content, toolbar: {})
    }

    func toolbar<Toolbar: View>(@ViewBuilder _ toolbar: @escaping () -> Toolbar) -> some View {
        _NavigationStackView(content: self.content, toolbar: toolbar)
    }
}
```

Tested with Xcode 13.2 / iOS 15.2
