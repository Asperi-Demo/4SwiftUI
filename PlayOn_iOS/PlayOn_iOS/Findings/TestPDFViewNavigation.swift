// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import PDFKit

struct TestPDFViewNavigation: View {
	var body: some View {
		PDFKitView(url: Bundle.main.url(forResource: "document", withExtension: "pdf")!)
	}

	struct PDFKitView: View {
		var url: URL

		@State var currentPage: Int = 0
		@State var total: Int = 0

		var body: some View {
			VStack {
				HStack {
					Button("<") { currentPage -= 1 }.padding()
						.disabled(currentPage == 0)
					Button(">") { currentPage += 1 }.padding()
						.disabled(currentPage == total - 1)
				}
				PDFKitRepresentedView(url, $currentPage, $total)
			}
		}
	}

	struct PDFKitRepresentedView: UIViewRepresentable {
		let url: URL
		@Binding var currentPage: Int
		@Binding var total: Int

		init(_ url: URL, _ currentPage: Binding<Int>, _ total: Binding<Int>) {
			self.url = url
			self._currentPage = currentPage
			self._total = total
		}

		func makeUIView(context: Context) -> UIView {
			guard let document = PDFDocument(url: self.url) else { return UIView() }

			let pdfView = PDFView()
			print("PDFVIEW IS CREATED")
			pdfView.document = document
			pdfView.displayMode = .singlePage
			pdfView.displayDirection = .horizontal
			pdfView.autoScales = true
			pdfView.usePageViewController(true)

			DispatchQueue.main.async {
				self.total = document.pageCount
				print("Total pages: \(total)")
			}
			return pdfView
		}

		func updateUIView(_ uiView: UIView, context: Context) {
			guard let pdfView = uiView as? PDFView else { return }

			if currentPage < total {
				pdfView.go(to: pdfView.document!.page(at: currentPage)!)
			}
		}

	}
}

struct TestPDFViewNavigation_Previews: PreviewProvider {
	static var previews: some View {
		TestPDFViewNavigation()
	}
}
