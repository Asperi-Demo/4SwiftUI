// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestScreenJoystick: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		
		@State var isDragging = false
		@State var dragValue = CGSize.zero
		
		var body: some View {
			VStack {
				Text("width: \(dragValue.width)")
				Text("height: \(dragValue.height)")
				VStack (spacing: 16) {
					HStack(spacing: 35) {
						Image(systemName: "chevron.left")
							.foregroundColor(.gray)
						
						
						VStack (spacing: 80) {
							Image(systemName: "chevron.up")
								.foregroundColor(.gray)
							Image(systemName: "chevron.down")
								.foregroundColor(.gray)
							
						}
						Image(systemName: "chevron.right")
							.foregroundColor(.gray)
						
					}
					
					
				}
				.offset(x: dragValue.width * 0.05, y: dragValue.height * 0.05)
				
				.frame(width: 150, height: 150)
				
				.background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.8705882353, green: 0.8941176471, blue: 0.9450980392, alpha: 1))]), startPoint: .top, endPoint: .bottom))
				.clipShape(RoundedRectangle(cornerRadius: isDragging ? (55 - abs(dragValue.height) / 10) : 55, style: .continuous))
				.offset(x: dragValue.width, y: dragValue.height)
				
				.shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
				.padding(.horizontal, 30)
				.gesture(
					DragGesture().onChanged { value in
						let limit: CGFloat = 200        // the less the faster resistance
						let xOff = value.translation.width
						let yOff = value.translation.height
						let dist = sqrt(xOff*xOff + yOff*yOff);
						let factor = 1 / (dist / limit + 1)
						self.dragValue = CGSize(width: value.translation.width * factor,
														height: value.translation.height * factor)
						self.isDragging = true
					}                .onEnded { value in
						self.dragValue = .zero
						self.isDragging = false
					}
				)
				.animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: dragValue)
			}
		}
	}    
}

struct TestScreenJoystick_Previews: PreviewProvider {
	static var previews: some View {
		TestScreenJoystick()
	}
}
