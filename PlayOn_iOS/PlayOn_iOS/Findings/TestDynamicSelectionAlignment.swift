// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

fileprivate extension HorizontalAlignment {
    private enum MonthAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[HorizontalAlignment.center]
        }
    }

    static let monthAlignment = HorizontalAlignment(MonthAlignment.self)
}

struct TestDynamicSelectionAlignment: View {

    let months = ["january" , "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
    @State private var selectedMonth = "october"
    var body: some View {


		VStack {
			VStack(alignment: .monthAlignment, spacing: 2) {
				Text(selectedMonth)
					.alignmentGuide(.monthAlignment, computeValue: { d in
						if self.selectedMonth == self.months.first {
							return d[.leading]
						} else if self.selectedMonth == self.months.last {
							return d[.trailing]
						} else {
							return d[HorizontalAlignment.center]
						}
					})
				HStack {
					ForEach(months, id: \.self) { month in
						Group {
							if month == self.selectedMonth {
								Rectangle()
									.foregroundColor(Color.red)
									.alignmentGuide(.monthAlignment, computeValue: { d in
										if month == self.months.first {
											return d[.leading]
										} else if month == self.months.last {
											return d[.trailing]
										} else {
											return d[HorizontalAlignment.center]
										}
									})
							} else {
								Rectangle()
							}
						}
						.frame(height: 10)
					}
				}
			}
			.padding()
			.animation(.easeInOut(duration: 0.5), value: selectedMonth)

            Button("Random Month") {
            	selectedMonth = months.randomElement()!
			}
		}
    }
}

struct TestDynamicSelectionAlignment_Previews: PreviewProvider {
    static var previews: some View {
        TestDynamicSelectionAlignment()
    }
}
