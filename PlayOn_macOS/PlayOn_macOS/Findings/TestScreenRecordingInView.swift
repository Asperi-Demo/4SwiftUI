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
		guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { fatalError("Cannot test w/o access to Documents") }
		destinationURL = documentsURL.appendingPathComponent("demo.mov")
	}

	@State private var recording = false

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
		.onChange(of: recording) {
			if $0 {
				recording = recorder.startRecording(to: destinationURL)
			} else {
				recorder.stop()
			}
		}
		.onAppear {
			recorder.completion = { _ in
				print("Done!")   // Something wrong - file is not created, but no error !!!
			}
		}
	}
}

struct TestScreenRecordingInView_Previews: PreviewProvider {
	static var previews: some View {
		TestScreenRecordingInView()
	}
}
