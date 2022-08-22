// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestOuterFrameHandling: View {

    @State var largeFrame: Bool = false

    var body: some View {
        VStack{
            Toggle("Large Frame", isOn: $largeFrame)

			MyView()
            .frame(maxWidth: largeFrame ? .infinity : nil)
            .border(Color.blue, width: 1)
        }
    }

	struct MyView: View {
		var outerWidth: CGFloat?

		@State private var myWidth = CGFloat.zero
		private let spacing = CGFloat(20)

		var body: some View {
            HStack(spacing: spacing) {
				SubViewA()
                .background(GeometryReader {
                    Color.clear.preference(key: ViewSideLengthKey.self,
                        value: $0.frame(in: .local).size.width)
                })

				if let width = outerWidth, width > myWidth {
					Spacer()
				}

				SubViewB()
                .background(GeometryReader {
                    Color.clear.preference(key: ViewSideLengthKey.self,
                        value: $0.frame(in: .local).size.width)
                })
            }
            .padding()
			.onPreferenceChange(ViewSideLengthKey.self) {
				myWidth = $0 + spacing
			}
		}

		@inlinable public func frame(minWidth: CGFloat? = nil, idealWidth: CGFloat? = nil, maxWidth: CGFloat? = nil, minHeight: CGFloat? = nil, idealHeight: CGFloat? = nil, maxHeight: CGFloat? = nil, alignment: Alignment = .center) -> some View {
			var newview = self
			newview.outerWidth = maxWidth
			return VStack { newview }   // << container to avoid cycling !!
			   .frame(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth, minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight, alignment: alignment)
		}


		struct SubViewA: View {
			var body: some View {
                Text("A")
                    .border(Color.red, width: 1)
			}
		}

		struct SubViewB: View {
			var body: some View {
                Text("B")
                    .border(Color.red, width: 1)
			}
		}

	}
}

struct TestOuterFrameHandling_Previews: PreviewProvider {
    static var previews: some View {
        TestOuterFrameHandling()
    }
}
