// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestKeyShortcutsButtonStyle: View {
	var body: some View {
		ContentView()
	}

	struct PlayerButton: ButtonStyle {

		@State private var onHover: Bool = false
		@State private var isPressed: Bool = false

		var foreground: Color {
			if isPressed {
				return .primary
			} else {
				return .secondary
			}
		}

		var background: AnyShapeStyle {
			if isPressed {
				return AnyShapeStyle(.ultraThickMaterial)
			} else if onHover {
				return AnyShapeStyle(.ultraThinMaterial)
			} else {
				return AnyShapeStyle(.background)
			}
		}

		func makeBody(configuration: Configuration) -> some View {
			configuration.label
				.padding()
				.foregroundColor(foreground)
				.background(background)
				.cornerRadius(5)
				.onHover { onHover in
					self.onHover = onHover
				}
				.onChange(of: configuration.isPressed) { isPressed in
					self.isPressed = isPressed
				}
		}

	}

	struct ContentView: View {
		var body: some View {

			ZStack {
				Button("", action: button3action)
					.opacity(0)
					.keyboardShortcut(.downArrow, modifiers: [])
				Button("Button 3", action: button3action)
					.buttonStyle(PlayerButton())
			}
		}

		func button3action() {
			print("3")
		}
	}
}

struct TestKeyShortcutsButtonStyle_Previews: PreviewProvider {
	static var previews: some View {
		TestKeyShortcutsButtonStyle()
	}
}
