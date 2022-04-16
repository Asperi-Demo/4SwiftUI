// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

public extension View {
	/// Full-screen cover for SwiftUI2.0+ (iOS 14) and created sheet as backward compatibility for SwiftUI1.0
	func compatibleFullScreen<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
		self.modifier(FullScreenModifier(isPresented: isPresented, builder: content))
	}
}

fileprivate struct FullScreenModifier<V: View>: ViewModifier {
	let isPresented: Binding<Bool>
	let builder: () -> V

	@ViewBuilder
	func body(content: Content) -> some View {
		if #available(iOS 14.0, *) {
			content.fullScreenCover(isPresented: isPresented, content: builder)
		} else {
			content.sheet(isPresented: isPresented, content: builder)
		}
	}
}
