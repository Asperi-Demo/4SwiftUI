// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestNoViewGenericTypeInit: View {
	var body: some View {
		NavigationView {
			VStack {
				// no external view
				ButtonPageView(lesson: Lesson(name: "First"))

				// page type is inferred from builder
				ButtonPageView(lesson: Lesson(name: "Second", page: {
					Text("Second Lesson")
				}))
			}
		}
	}

	class Lesson<T: View>: Identifiable {

		// give convenience initializer with Never for view type !!
		convenience init(name: String) where T == Never {
			self.init(name: name, page: nil)
		}

		init(name: String, page: (() -> T)?) {
			self.lessonName = name
			self.builder = page
		}

		let id = UUID()
		var lessonName: String

		var builder: (() -> T)?    // << optional builder
		
		@ViewBuilder
		func makePage() -> some View {   // ViewBuilder gives possibility
			if let page = builder?() {     // to provide default view
				page
			} else {
				Text("DefaultPage")
			}
		}

	}

	struct ButtonPageView<Page: View>: View {
		var lesson: Lesson<Page>

		var body: some View {
			NavigationLink(destination: lesson.makePage()) {
				Text(lesson.lessonName)
			}
		}
	}
}

struct TestNoViewGenericTypeInit_Previews: PreviewProvider {
	static var previews: some View {
		TestNoViewGenericTypeInit()
	}
}
