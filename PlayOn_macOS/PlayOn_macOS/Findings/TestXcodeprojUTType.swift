// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI
import UniformTypeIdentifiers

struct TestXcodeprojUTType: View {
	@State private var fileImporterIsPresented: Bool = false

	private let xcodeproj: UTType

	init() {
		guard let type = UTType(tag: "xcodeproj", tagClass: .filenameExtension, conformingTo: .compositeContent) else { fatalError() }
		xcodeproj = type
	}

	var body: some View {

		Button("Select your Xcode projext") { fileImporterIsPresented = true }
			.fileImporter(isPresented: $fileImporterIsPresented, allowedContentTypes: [xcodeproj], allowsMultipleSelection: false, onCompletion: { result in

				switch result {
				case .success(let urls):

					if let unwrappedURL: URL = urls.first {
						print(unwrappedURL.path)
					}

				case .failure(let error):
					print("Error selecting file \(error.localizedDescription)")
				}

			})

		Button("Open") {
			let panel = NSOpenPanel()
			panel.allowsMultipleSelection = false
			panel.allowedContentTypes = [xcodeproj]
			panel.canChooseDirectories = false
			if panel.runModal() == .OK {
				print(">> ", panel.urls)
			}
		}

	}
}

struct TestXcodeprojUTType_Previews: PreviewProvider {
	static var previews: some View {
		TestXcodeprojUTType()
	}
}
