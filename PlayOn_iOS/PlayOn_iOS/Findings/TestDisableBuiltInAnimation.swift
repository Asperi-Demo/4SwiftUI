// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi


import SwiftUI

struct TestDisableBuiltInAnimation: View {
        let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        let years = 1990..<2025
        @State private var pickedMonth = "May"
        @State private var pickedYear = 2022
        
        var body: some View {
            HStack(spacing: 5) {
                Menu {
                    ForEach(months, id: \.self) { month in
                        Button(month) {
                            pickedMonth = month
                        }
                    }
                } label: {
                    Text("\(pickedMonth),")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.blue)
                }
                
                Menu {
                    ForEach(years, id: \.self) { year in
                        Button(String(year)) {
                            pickedYear = year
                        }
                    }
                } label: {
                    Text(String(pickedYear))
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.blue)
                }
            }
            // allows to intercept this view trasformations (on refresh)
            // and modify some parameters, eg. remove any animation,
            // even used internally
            .transaction {
                $0.animation = nil
            }
        }
    }

struct TestDisableBuiltInAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestDisableBuiltInAnimation()
    }
}
