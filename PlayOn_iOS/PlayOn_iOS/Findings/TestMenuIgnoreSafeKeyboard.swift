// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestMenuIgnoreSafeKeyboard: View {

	@State var text = ""
	var body: some View {
		VStack {
			Spacer()
			TextField("This is TextField", text: $text)
				.textFieldStyle(.roundedBorder)
			Spacer()
			HStack{
				Text("Text")
				ViewWithMenu()
			}
			.fixedSize()      // << fix !!
		}
		.ignoresSafeArea(.keyboard, edges: .bottom)
	}

	struct ViewWithMenu: View {
		@State var selection = ""
		let foo = ["One","Two","Three"]
		var body: some View {
			Menu(content:{
				Picker(selection: $selection, label:
						EmptyView()
					   , content: {
					ForEach(foo,id:\.self){f in
						Label(f, systemImage: "car")
							.tag(f)
					}
				})
				Picker(selection: $selection, label:
						EmptyView()
					   , content: {
					Label("Add", systemImage: "plus.circle.fill")
						.tag("Add")
				})
			},label:{
				Text("Menu").fixedSize()
			})
		}
	}
}

struct TestMenuIgnoreSafeKeyboard_Previews: PreviewProvider {
	static var previews: some View {
		TestMenuIgnoreSafeKeyboard()
	}
}
