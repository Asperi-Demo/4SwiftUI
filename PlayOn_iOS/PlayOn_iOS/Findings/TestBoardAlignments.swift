// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestBoardAlignments: View {
    var body: some View {
        BoardView()
    }
}

struct TestBoardAlignments_Previews: PreviewProvider {
    static var previews: some View {
        TestBoardAlignments()
    }
}

extension VerticalAlignment {
   private enum VCenterAlignment: AlignmentID {
      static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
         return dimensions[VerticalAlignment.center]
      }
   }
   static let vCenterred = VerticalAlignment(VCenterAlignment.self)
}

extension HorizontalAlignment {
   private enum HCenterAlignment: AlignmentID {
      static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
         return dimensions[HorizontalAlignment.center]
      }
   }
   static let hCenterred = HorizontalAlignment(HCenterAlignment.self)
}

struct BoardView: View {
	@State private var selection = 1
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .hCenterred, vertical: .vCenterred)) {
            VStack {
                HStack {
                    TileView(number: 1, selection: $selection)
                    TileView(number: 2, selection: $selection)
                }
                HStack {
                    TileView(number: 3, selection: $selection)
                    TileView(number: 4, selection: $selection)
                }
            }
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(Color.red.opacity(0.8))
                .alignmentGuide(.vCenterred) { $0[VerticalAlignment.center] }
                .alignmentGuide(.hCenterred) { $0[HorizontalAlignment.center] }
        }
        .padding()
        .animation(.spring(), value: selection)
    }

	struct TileView: View {
		var number: Int
		@Binding var selection: Int

		private var vAlignment: VerticalAlignment { selection == number ? .vCenterred : .center }
		private var hAlignment: HorizontalAlignment { selection == number ? .hCenterred : .center }

		var body: some View {
			RoundedRectangle(cornerRadius: 20)
				.aspectRatio(contentMode: .fit)
				.overlay(Text("\(number)").foregroundColor(.white))
				.onTapGesture {
					selection = number
				}
				.alignmentGuide(vAlignment) { $0[VerticalAlignment.center] }
				.alignmentGuide(hAlignment) { $0[HorizontalAlignment.center] }
		}
	}
}
