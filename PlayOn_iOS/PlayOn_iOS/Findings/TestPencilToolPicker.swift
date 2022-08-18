// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import PencilKit

struct TestPencilToolPicker: View {
	struct CanvasView: UIViewRepresentable {

		class Coordinator: NSObject, PKCanvasViewDelegate {
			var canvasView: Binding<PKCanvasView>
			let onChange: () -> Void
			private let toolPicker: PKToolPicker

			deinit {       // << here !!
				toolPicker.setVisible(false, forFirstResponder: canvasView.wrappedValue)
				toolPicker.removeObserver(canvasView.wrappedValue)
			}

			init(canvasView: Binding<PKCanvasView>, toolPicker: PKToolPicker, onChange: @escaping () -> Void) {
				self.canvasView = canvasView
				self.onChange = onChange
				self.toolPicker = toolPicker
			}

			func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
				if canvasView.drawing.bounds.isEmpty == false {
					onChange()
				}
			}
		}

		@Binding var canvasView: PKCanvasView
		@Binding var toolPickerIsActive: Bool
		private let toolPicker = PKToolPicker()

		let onChange: () -> Void

		func makeUIView(context: Context) -> PKCanvasView {
			canvasView.backgroundColor = .clear
			canvasView.isOpaque = true
			canvasView.delegate = context.coordinator
			showToolPicker()

			return canvasView
		}

		func updateUIView(_ uiView: PKCanvasView, context: Context) {
			toolPicker.setVisible(toolPickerIsActive, forFirstResponder: uiView)
		}

		func showToolPicker() {
			toolPicker.setVisible(true, forFirstResponder: canvasView)
			toolPicker.addObserver(canvasView)
			canvasView.becomeFirstResponder()
		}

		func makeCoordinator() -> Coordinator {
			Coordinator(canvasView: $canvasView, toolPicker: toolPicker, onChange: onChange)
		}
	}

	@State private var canvasView = PKCanvasView()
	@State private var toolPickerIsActive = false
	@State private var canvasIsVisible = false

	var body: some View {
		ZStack {
			if canvasIsVisible {
				CanvasView(canvasView: $canvasView,
						   toolPickerIsActive: $toolPickerIsActive,
						   onChange: canvasDidChange)
				.onAppear { toolPickerIsActive = true }
				//                    .onDisappear { toolPickerIsActive = false }
			}

			Button(action: {
				canvasIsVisible.toggle()
			}, label: {
				Text("Toggle canvas view")
			})
		}
	}

	private func canvasDidChange() {
		// Do something with updated canvas.
	}
}

struct TestPencilToolPicker_Previews: PreviewProvider {
	static var previews: some View {
		TestPencilToolPicker()
	}
}
