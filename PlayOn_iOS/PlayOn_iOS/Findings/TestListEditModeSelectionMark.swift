// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestListEditModeSelectionMark: View {
    @State private var data = [Int]()
    @State private var editMode = EditMode.inactive
    @State private var selects = Set<Int>()
    @State private var base = 0

	@State private var forceRefresh = false   // << this !!

    var body: some View{
        VStack{
            Button {
                if editMode.isEditing{
                    editMode = .inactive
                }else{
                    editMode = .active
                }
				// cannot use `editMode` directly because it is also
				// changed on swipe to delete
                forceRefresh.toggle()
            } label: {
                Text(editMode.isEditing ? "Done" : "Edit")
            }

            Button {
                base += 1
                data.append(base)
            } label: {
                Text("Insert")
            }

            List(selection: $selects){
                ForEach(data, id:\.self){item in
                    Text(String(item)).id(item)
                }
                .onDelete{
                    data.remove(atOffsets: $0)
                }
            }
            .id(forceRefresh)        // << here !!
        }
        .environment(\.editMode, $editMode)
    }
}

struct TestListEditModeSelectionMark_Previews: PreviewProvider {
    static var previews: some View {
        TestListEditModeSelectionMark()
    }
}
