// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import Foundation
import AVFoundation

class ScreenRecorder: NSObject {
	private var captureSession: AVCaptureSession?
	private var captureOutput: AVCaptureMovieFileOutput?

	var completion: ((Error?) -> Void)?
	init(completion: ((Error?) -> Void)? = nil) {
		self.completion = completion
	}

	func startRecording(to destination: URL, in rect: CGRect? = nil) -> Bool {
		guard destination.isFileURL &&
			!FileManager.default.fileExists(atPath: destination.path) else { return false }

		let session = AVCaptureSession()
		session.sessionPreset = .high

		session.beginConfiguration()
		// for simplicity on main desplay only
		guard let input = AVCaptureScreenInput(displayID: CGMainDisplayID()) else { return false }
		if let cropRect = rect {
			input.cropRect = cropRect
		}
		input.capturesCursor = true
		input.capturesMouseClicks = true
		guard session.canAddInput(input) else { return false }
		session.addInput(input)

		let output = AVCaptureMovieFileOutput()
		guard session.canAddOutput(output) else { return false }
		session.addOutput(output)
		session.commitConfiguration()
		
		session.startRunning()
		output.startRecording(to: destination, recordingDelegate: self)

		captureSession = session
		captureOutput = output
		return true
	}

	func stop() {
		captureOutput?.stopRecording()
	}
}

extension ScreenRecorder: AVCaptureFileOutputRecordingDelegate {
	func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {

	}

	func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
		captureSession?.stopRunning()
		captureSession = nil
		captureOutput = nil
		completion?(error)
	}
}
