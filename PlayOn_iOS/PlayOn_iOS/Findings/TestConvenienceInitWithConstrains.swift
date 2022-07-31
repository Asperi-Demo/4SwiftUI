// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestConvenienceInitWithConstrains: View {
	var body: some View {
		VStack {
			ForEachKeypath(data: ["1", "2", "3"].indices, selection: .constant(0)) { Text("\($0)")
			}
		}
	}
}

struct TestConvenienceInitWithConstrains_Previews: PreviewProvider {
	static var previews: some View {
		TestConvenienceInitWithConstrains()
	}
}

struct ForEachKeypath<T: RandomAccessCollection, ElementView: View, ID: Hashable>: View {
	
	@Binding var selection: T.Element
	let keyPath: KeyPath<T.Element, ID>
	let content: (T.Element) -> ElementView
	var data: T
	
	init(data: T, id: KeyPath<T.Element, ID>, selection: Binding<T.Element>, @ViewBuilder content: @escaping (T.Element) -> ElementView) {
		self._selection = selection
		self.data = data
		self.content = content
		self.keyPath = id
	}
	
	var body: some View {
		ForEach(data, id: keyPath) { element in
			content(element)
		}
	}
}

extension ForEachKeypath {
	init(data: T, selection: Binding<T.Element>, @ViewBuilder content: @escaping (T.Element) -> ElementView) where ID == T.Element {
		self.init(data: data, id: \.self, selection: selection, content: content)
	}
}
