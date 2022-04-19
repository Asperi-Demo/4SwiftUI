// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestScreenRecordingInView: View {
	private let recorder = ScreenRecorder()
	private let destinationURL: URL

	init() {
		guard let documentsURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first else { fatalError("Cannot test w/o access to Documents") }
		destinationURL = documentsURL.appendingPathComponent("demo.mov")
	}

	@State private var recording = false
	@State private var viewRect = CGRect.zero

	var body: some View {
		VStack {
			Text("Hello, World!")
			Button(recording ? "Stop" : "Start") {
				let fileManager = FileManager.default
				if fileManager.fileExists(atPath: destinationURL.path) {
					guard (try? fileManager.removeItem(at: destinationURL)) != nil else {
						print("Cannot clean destination, remove manually!")
						return
					}
				}
				recording.toggle()
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(GeometryReader {
			Color.clear.preference(key: ViewRectKey.self, value: $0.frame(in: .global))
		})
		.onPreferenceChange(ViewRectKey.self) {
			viewRect = $0
		}
		.onChange(of: recording) {
			if $0 {
				var cropRect: CGRect?
				if let window = NSApp.mainWindow {
					cropRect = window.convertToScreen(viewRect)
				}
				recording = recorder.startRecording(to: destinationURL, in: cropRect)
			} else {
				recorder.stop()
			}
		}
		.onAppear {
			recorder.completion = { _ in
				print("Done!")
				// Something wrong - file is not created, but no error !!!
			}
		}
	}
}

struct TestScreenRecordingInView_Previews: PreviewProvider {
	static var previews: some View {
		TestScreenRecordingInView()
	}
}

struct ViewRectKey: PreferenceKey {
	static var defaultValue: CGRect = .zero
	static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
		value = nextValue()
	}
}
