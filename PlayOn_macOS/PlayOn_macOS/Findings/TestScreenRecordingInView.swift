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
				if !recording && !validate(destinationURL) {
					return
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
				recording = recorder.startRecording(to: destinationURL, in: viewRect)
			} else {
				recorder.stop()
			}
		}
		.onAppear {
			recorder.completion = { _ in
				NSWorkspace.shared.open(destinationURL)
			}
		}
	}

	func validate(_ url: URL) -> Bool {
		let fileManager = FileManager.default
		if fileManager.fileExists(atPath: url.path) {
			guard (try? fileManager.removeItem(at: url)) != nil else {
				print("Cannot clean destination, remove manually!")
				return false
			}
		}
		return true
	}
}

struct TestScreenRecordingInView_Previews: PreviewProvider {
	static var previews: some View {
		TestScreenRecordingInView()
	}
}
