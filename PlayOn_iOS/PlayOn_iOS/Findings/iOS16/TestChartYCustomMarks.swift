// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

#if canImport(Charts)
import Charts

@available (iOS 16, *)
struct TestChartYCustomMarks: View {
    let heartRateData = [80.0, 90.0, 120.0, 150.0, 160.0, 140.0, 125.0, 110.0, 88.0]
    
    let yValues = stride(from: 0, to: 220, by: 10).map { $0 }
    var body: some View {
        Chart {
            ForEach(heartRateData, id: \.self) { sample in
                LineMark(
                    x: .value("", heartRateData.firstIndex(of: sample)!),
                    y: .value("HR", sample))
                .foregroundStyle(Color.red)
            }
        }
        .chartYAxis{
            AxisMarks(position: .leading, values: yValues)
        }
        .frame(height: 300)
        .padding(.horizontal)
        .chartYScale(domain: 0...210)
    }
}

@available (iOS 16, *)
struct TestChartYCustomMarks_Previews: PreviewProvider {
    static var previews: some View {
        TestChartYCustomMarks()
    }
}
#endif
