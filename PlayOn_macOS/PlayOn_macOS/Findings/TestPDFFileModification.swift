// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import PDFKit

struct TestPDFFileModification: View {

	var body: some View {
		Button("Test") {
			process(pdf: Bundle.main.url(forResource: "Test", withExtension: "pdf")!, text: "InJeCtEd", textAttributes: [NSAttributedString.Key.foregroundColor : NSColor.red])
		}
	}
}

func process(pdf input:URL, text: NSString, textAttributes: [NSAttributedString.Key: Any]?) {
	let pdffile = PDFDocument(url: input)
	let data = NSMutableData()
	let consumer = CGDataConsumer(data: data as CFMutableData)!

	// create common context with no mediaBox, we will add it later
	// per-page (because, actually they might be different)
	let context = CGContext(consumer: consumer, mediaBox: nil, nil)!

	for y in stride(from: 0, to: pdffile!.pageCount, by: 1)
	{
		let page: PDFPage = pdffile!.page(at: y)!

		// re-use media box of original document as-is w/o changes !!
		var mediaBox = page.bounds(for: PDFDisplayBox.mediaBox)
		NSGraphicsContext.current = NSGraphicsContext(cgContext: context, flipped: false)

		// prepare mediaBox data for page setup
		let rectData = NSData(bytes: &mediaBox, length: MemoryLayout.size(ofValue: mediaBox))

		context.beginPDFPage([kCGPDFContextMediaBox as String: rectData] as CFDictionary)   // << here !!

		page.draw(with: .mediaBox, to: context) // << original !!

		// >> hardcoded to simplify testing <<
		text.draw(at: CGPoint(x: 40, y: 40), withAttributes: textAttributes) // << over !!

		context.endPDFPage()
	}
	context.closePDF()  // close entire document

	let anotherDocument = PDFDocument(data:data as Data)
	for y in stride(from: 0, to: pdffile!.pageCount, by: 1)
	{
		let page: PDFPage = pdffile!.page(at: y)!
		let newPage: PDFPage = anotherDocument!.page(at: y)!
		for anotatation in page.annotations {
			newPage.addAnnotation(anotatation)
		}
	}

	let output = NSTemporaryDirectory() + "new.pdf"
	anotherDocument?.write(toFile: output)
	print(output)
}

struct TestPDFFileModification_Previews: PreviewProvider {
    static var previews: some View {
        TestPDFFileModification()
    }
}
