>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Sliding view up by MatchedGeometryEffect (by Tamás Horváth)

A: Location of modifier matters, and for `matchedGeometryEffect` it is important even more.

Here is fixed variant. Xcode 13.2 / iOS 15.2

![PVwgE](https://user-images.githubusercontent.com/62171579/182877038-5d49305c-361e-42da-a6c2-c1dd188c9dfa.gif)

	var body: some View {
		if isShowingDetail {
			VStack {
				Rectangle()
					.foregroundColor(.black)
					.aspectRatio(contentMode: .fit)
					.edgesIgnoringSafeArea(.top)
                                                // !! applied here !!
  					.matchedGeometryEffect(id: "image", in: namespace, properties: .position)
				Spacer()
			}
			.onTapGesture {
				changeView()
			}
		} else {
			Rectangle()
				.foregroundColor(.black)
				.aspectRatio(contentMode: .fit)
				.cornerRadius(8)
                                   // !! applied here !!
				.matchedGeometryEffect(id: "image", in: namespace, properties: .position)
				.onTapGesture {
					changeView()
				}
		}
	}
