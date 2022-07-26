```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
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

