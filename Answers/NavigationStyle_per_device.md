```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI set navigationViewStyle based on device (by stardust4891)

A: I recommend to extract it into simple wrapper modifier and use it in place where needed. Here is modifier:

## Update:

```
extension View {
	@ViewBuilder
	public func currentDeviceNavigationViewStyle() -> some View {
		if UIDevice.current.userInterfaceIdiom == .pad {
			self.navigationViewStyle(StackNavigationViewStyle())
		} else {
			self.navigationViewStyle(DefaultNavigationViewStyle())
		}
	}
}
```

## SwiftUI 1.0 (backward-compatible)

    extension View {
        public func currentDeviceNavigationViewStyle() -> AnyView {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
            } else {
                return AnyView(self.navigationViewStyle(DefaultNavigationViewStyle()))
            }
        }
    }

