```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Draw text on all pages of PDF using PDFKit (by techno)

A: The main issue here is that context recreated, for multiple pages we should write into the same context (it manages pages by beginPDFPage/endPDFPage pair).

Here is fixed code. Tested with Xcode 13.4 / macOS 12.4

```
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
    text.draw(in:drawrect,withAttributes:textFontAttributes) // << over !!

	context.endPDFPage()
}
context.closePDF()  // close entire document

let anotherDocument = PDFDocument(data:data as Data)
// ... as used before
```
