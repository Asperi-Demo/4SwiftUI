// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestButtonActionWhilePressed: View {

    @State var direction = "Empty"
    @State var animate = false

	struct StateButton: ButtonStyle {
		var onStateChanged: (Bool) -> Void
		func makeBody(configuration: Configuration) -> some View {
			configuration.label
				.opacity(configuration.isPressed ? 0.5 : 1)  // << press effect
				.onChange(of: configuration.isPressed) {
					onStateChanged($0)  // << report if pressed externally
				}
		}
	}

    var body: some View {
        ZStack {
            VStack {
                Text("\(direction) + \(String(describing: animate))")
                    .padding()
                Spacer()
            }
            VStack(spacing: 0) {
                Rectangle()
                    .frame(width: 35, height: 60)
                    .foregroundColor(.gray.opacity(0.3))
                    .overlay(
                        Button {
							direction = "Ended"
                        } label: {
                            VStack {
                                Image(systemName: "arrowtriangle.up.fill")
                                    .foregroundColor(.black.opacity(0.4))
                                Spacer()
                            }
                            .padding(.top, 10)
                        }
                        .buttonStyle(StateButton {
							animate = $0
							if $0 {
	                            direction = "Up"
							}
						})
                    )

                Rectangle()
                    .frame(width: 35, height: 60)
                    .foregroundColor(.gray.opacity(0.3))
                    .overlay(
                        Button {
                            direction = "Down"
                            animate = true

                        } label: {
                            VStack {
                                Spacer()
                                Image(systemName: "arrowtriangle.down.fill")
                                    .foregroundColor(.black.opacity(0.4))
                            }
                                .padding(.bottom, 10)
                                .gesture(
                                    TapGesture()
                                        .onEnded({ () in
                                            direction = "Ended"
                                            animate = false
                                        })
                                )
                        }
                    )
            }
            HStack(spacing: 35) {
                Rectangle()
                    .frame(width: 43, height: 35)
                    .foregroundColor(.gray.opacity(0.3))
                    .overlay(
                        Button {
                            direction = "Left"
                            animate = true

                        } label: {
                            VStack {
                                Image(systemName: "arrowtriangle.left.fill")
                                    .foregroundColor(.black.opacity(0.4))
                                Spacer()
                            }
                                .padding(.top, 10)
                                .gesture(
                                    TapGesture()
                                        .onEnded({ () in
                                            direction = "Ended"
                                            animate = false
                                        })
                                )
                        }
                    )
                Rectangle()
                    .frame(width: 43, height: 35)
                    .foregroundColor(.gray.opacity(0.3))
                    .overlay(
                        Button {
                            direction = "Right"
                            animate = true

                        } label: {
                            VStack {
                                Spacer()
                                Image(systemName: "arrowtriangle.right.fill")
                                    .foregroundColor(.black.opacity(0.4))
                            }
                                .padding(.bottom, 10)
                                .gesture(
                                    TapGesture()
                                        .onEnded({ () in
                                            direction = "Ended"
                                            animate = false
                                        })
                                )
                        }
                    )
            }
        }
    }
}

struct TestButtonActionWhilePressed_Previews: PreviewProvider {
    static var previews: some View {
        TestButtonActionWhilePressed()
    }
}
