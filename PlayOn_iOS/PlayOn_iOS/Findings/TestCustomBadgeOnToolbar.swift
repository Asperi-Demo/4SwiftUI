// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCustomBadgeOnToolbar: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Test")
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    ControlGroup {
                        Button(action: {}) {
                            Label("Button 1", systemImage: "doc")
                        }
                        Button(action: {}) {
                            Label("Button 2", systemImage: "checkmark")
                        }
                        Button(action: {}) {
                            Label("Button 3", systemImage: "person")
                        }
                    }
                    .overlay(HStack(alignment: .top) {
                    	Image(systemName: "1").foregroundColor(.green)
                    		.frame(maxWidth: .infinity)
                    	Image(systemName: "3").foregroundColor(.orange)
                    		.frame(maxWidth: .infinity)
                    	Image(systemName: "9").foregroundColor(.purple)
                    		.frame(maxWidth: .infinity)
						}
						.frame(maxHeight: .infinity)
						.symbolVariant(.fill)
						.symbolVariant(.circle)
						.offset(x: 10, y: -10)
					)
                }
            }
        }
    }
}

struct TestCustomBadgeOnToolbar_Previews: PreviewProvider {
    static var previews: some View {
        TestCustomBadgeOnToolbar()
    }
}
