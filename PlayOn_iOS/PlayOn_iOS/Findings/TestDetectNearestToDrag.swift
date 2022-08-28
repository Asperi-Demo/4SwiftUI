// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestDetectNearestToDrag: View {

    private var sArray = ["e", "s", "p", "b", "k"]
    @State var isShowPopup: Bool = false
    @State private var dragPosition = CGPoint.zero

    @State private var rects = [Int: CGRect]()
    @State private var selected = -1

    var body: some View {

        VStack() {
            Spacer()
            Text("global: \(self.dragPosition.x) : \(self.dragPosition.y)")

            if isShowPopup {
                HStack(spacing: 5) {
                    ForEach(sArray.indices, id: \.self) { id in
                        Text("\(self.sArray[id])").fontWeight(.bold).font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(id == self.selected ? Color.red : Color.blue)
                            .cornerRadius(5)
                            .background(self.rectReader(for: id))  // << on layout !!
                    }
                }.offset(x:40, y:0)
            }

            Text("A").frame(width: 60, height: 90)
                .foregroundColor(.white)
                .background(Color.purple)
                .shadow(radius: 2)
                .padding(10)
                .gesture(gesture)
        }
    }

	var gesture: some Gesture {
		DragGesture(minimumDistance: 2, coordinateSpace: .global)
			.onChanged { drag in
				self.dragPosition = drag.location

				// compare stored coordinates during layout with drag location
				if let (id, _) = self.rects.first(where: { (_, value) -> Bool in
					value.minX < drag.location.x && value.maxX > drag.location.x
				}) { self.selected = id }

				if !self.isShowPopup {
					self.isShowPopup.toggle()
				}
			}
			.onEnded { _ in
				if self.isShowPopup {
					self.isShowPopup.toggle()
				}
			}
	}

	// helper to read view frame from background and store in state
    func rectReader(for key: Int) -> some View {
        return GeometryReader { gp in
        	Color.clear
        		.onAppear {
					self.rects[key] = gp.frame(in: .global)
				}
				.onChange(of: gp.size) { _ in
					self.rects[key] = gp.frame(in: .global)
				}
        }
    }
}

struct TestDetectNearestToDrag_Previews: PreviewProvider {
    static var previews: some View {
        TestDetectNearestToDrag()
    }
}
