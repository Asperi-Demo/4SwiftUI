// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import UniformTypeIdentifiers

struct TestFileExporterJSON2CSV: View {

	let json = """
	[
	 {
	  "_id" : 1,
	  "_name" : "Label1",
	  "_type" : "type1",
	  "_description" : "description1",
	  "_label" : ""
	 },
	 {
	  "_id" : 2,
	  "_name" : "Label2",
	  "_type" : "type2",
	  "_description" : "description2",
	  "_label" : ""
	 }
	]
	"""

	func load<T: Decodable>(_ content: String) -> T {
		guard let data: Data = content.data(using: .utf8) else {
			fatalError()
		}
		do {
			let decoder = JSONDecoder()
			return try decoder.decode(T.self, from: data)
		} catch {
			fatalError()
		}
	}

	@State private var name = ""
	@FocusState private var nameIsFocused: Bool
	@State var labels: [LabelData] = []
	@State var index = 0
	@State var saveFile = false


	var body: some View {
		HStack {
			Button(action: {
				index += 1

				if index <= labels.count {
					labels[index - 1]._label = "Yellow" }
			}) {
				Text("Y")
			}
			Button(action: {
				saveFile.toggle()
				//print(labels[index - 1])
			}) {
				Text("Export")
					.frame(width: 100, height: 100)
					.foregroundColor(Color(red: 0.362, green: 0.564, blue: 1))
					.background(Color(red: 0.849, green: 0.849, blue: 0.849))
					.clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
			}
			.offset(x: 0, y: 0)
			.fileExporter(isPresented: $saveFile, document: Doc(content: labels), contentType: .plainText) {
				switch $0 {
				case let .success(url):
					print(url)
				case let .failure(error):
					print(error)
				}
			}
		}
		VStack{
			VStack {
				if index < labels.count{
					if let test = labels[index] {
						Text(test._name)
					}}}
			.offset(x: 0, y: -250)
			.frame(
				minWidth: 0,
				maxWidth: 325
			)
			VStack {
				if index < labels.count{
					if let test = labels[index] {
						Text(test._name)
					}}}
			.offset(x: 0, y: -150)
			.frame(
				minWidth: 0,
				maxWidth: 325
			)
			VStack {
				if index < labels.count{
					if let test = labels[index] {
						Text(test._label)
					}}}
			.offset(x: 0, y: -50)
			.frame(
				minWidth: 0,
				maxWidth: 325
			)
		}
		.onAppear {

			labels = load(json)
		}
	}

	struct LabelData: Codable {

		var _id: Int
		var _name: String
		var _type: String
		var _description: String
		var _label: String
	}

	struct Doc: FileDocument {

		static var readableContentTypes: [UTType] { [.plainText] }

		private var content: [LabelData]
		init(content: [LabelData]) {
			self.content = content
		}

		init(configuration: ReadConfiguration) throws {
			// read content from configuration.file
			self.content = []
		}

		func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
			let text = content.reduce("") {
				$0 + "\($1._id),\($1._name),\($1._type),\($1._description),\($1._label)\n"
			}
			return FileWrapper(regularFileWithContents: text.data(using: .utf8) ?? Data())
		}
	}
}

struct TestFileExporterJSON2CSV_Previews: PreviewProvider {
	static var previews: some View {
		TestFileExporterJSON2CSV()
	}
}
