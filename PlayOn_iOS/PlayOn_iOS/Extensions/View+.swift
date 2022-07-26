// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

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

// MARK: -

public extension View {
	// Get rect of a view in specified coordinate space, by default in global, so by default it
	// provides view's frame in window coordinates, to have bounds specify .local, to have in some
	// parent provide named coordinate space correspondingly.
	func reading(rect binding: Binding<CGRect>, in space: CoordinateSpace = .global) -> some View {
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

// MARK: -
extension View {
    func asImage() -> UIImage {
        let controller = UIHostingController(rootView: self)

        // locate far out of screen
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)

        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        UIApplication.shared.windows.first?.rootViewController?.view.addSubview(controller.view)

        let image = controller.view.asImage()
        controller.view.removeFromSuperview()
        return image
    }
}

// MARK: -
extension View {
	@ViewBuilder
	func labelStyle(includingText: Bool) -> some View {
		if includingText {
			self.labelStyle(.titleAndIcon)
		} else {
			self.labelStyle(.iconOnly)
		}
	}
}

