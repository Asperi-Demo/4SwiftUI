// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestTwoEdiatableLists: View {
	var body: some View {
		NavigationView {
			VStack{
				EmbedList1()
				EmbedList2()
			}
		}
	}
	
	struct EmbedList1: View{
		@State var editMode: EditMode = .inactive
		var body: some View{
			VStack{
				Button(editMode == .inactive ? "Edit" : "Done") {
					editMode = editMode == .active ? .inactive : .active
				}
				List{
					ForEach(1..<5){_ in
						Text("List1")
					}
					.onMove(perform: relocate)
				}
			}
			.environment(\.editMode, $editMode)
		}
		
		func relocate(from source: IndexSet, to destination: Int) {
		}
	}
	
	struct EmbedList2: View{
		@State var editMode: EditMode = .inactive
		var body: some View{
			VStack{
				Button(editMode == .inactive ? "Edit" : "Done") {
					editMode = editMode == .active ? .inactive : .active
				}
				List{
					ForEach(1..<5){_ in
						Text("List1")
					}
					.onMove(perform: relocate)
				}
			}
			.environment(\.editMode, $editMode)
		}
		
		func relocate(from source: IndexSet, to destination: Int) {
		}
	}
}

struct TestTwoEdiatableLists_Previews: PreviewProvider {
	static var previews: some View {
		TestTwoEdiatableLists()
	}
}
