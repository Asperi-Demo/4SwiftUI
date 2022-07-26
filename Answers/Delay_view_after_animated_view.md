```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: Show specific views with an animation delay (by kirkyoyx)

A: We need to make separated animation (and related state) for `ScrollView` in this scenario.

Here is possible approach. Tested with Xcode 12.1 / iOS 14.1

![oVMYN](https://user-images.githubusercontent.com/62171579/176450089-6ac7128a-f797-4741-a684-2538b008c43c.gif)

```
struct Playground: View {
	@Namespace var namespace
	@State var show = false
	private let gridItems = [GridItem(.flexible())]
	
	@State private var showItems = false
	
	var body: some View {
		
		if show {
			VStack{
				ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
					Rectangle()
						.matchedGeometryEffect(id: "A", in: namespace, isSource: show)
						.frame(height: 300)
						.frame(maxWidth: .infinity)
					
					Image(systemName: "xmark")
						.font(.system(size: 25))
						.foregroundColor(.white)
						.background(Color.red)
						.padding(20)
						.onTapGesture {
							withAnimation(.spring()){
								self.show = false
							}
						}
				}
				
				VStack {
					if showItems {
						ScrollView{
							LazyVGrid(columns: gridItems){
								ForEach(0..<10){ cell in
									Text("\(cell)")
								}
							}
						}
					} else {
						Spacer()
					}
				}
				.onAppear { showItems = true }
				.onDisappear { showItems = false }
				.animation(Animation.spring().delay(3), value: showItems)
			}
		} else {
			Rectangle()
				.matchedGeometryEffect(id: "A", in: namespace, isSource: !show)
				.frame(width: 100, height: 100)
				.onTapGesture {
					withAnimation(.spring()){
						self.show = true
					}
				}
		}
	}
}
```
