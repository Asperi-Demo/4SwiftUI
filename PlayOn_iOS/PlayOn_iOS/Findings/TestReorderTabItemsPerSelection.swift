// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestReorderTabItemsPerSelection: View {

	@State private var selection: String = "house"
    @State private var tbHeight = CGFloat.zero
    
	struct Item {
		let title: String
		let color: Color
		let icon: String
	}
	@State var items = [
		Item(title: "cart", color: .red, icon: "cart"),
		Item(title: "house", color: .blue, icon: "house"),
		Item(title: "car", color: .green, icon: "car"),
	]
    
    var selected: Item {
        items.first { $0.title == selection } ?? items[0]
    }
    
	var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                ForEach(items, id: \.title) { item in
                    TabContent(height: $tbHeight) {
                        item.color
                    }.tabItem {
                        if selection != item.title {
                            Image(systemName: item.icon)
                            Text(item.title)
                        }
                    }
                }
            }
            .onChange(of: selection) { title in
                let target = 1
                if var i = items.firstIndex(where: { $0.title == title }) {
                    if i > target {
                        i += 1
                    }
                    items.move(fromOffsets: IndexSet(integer: target), toOffset: i)
                }
            }

            TabSelection(height: tbHeight, item: selected)
        }
	}
    
    struct TabSelection: View {
        let height: CGFloat
        let item: Item
        
        var body: some View {
            VStack {
                Spacer()
                Curve()
                    .frame(maxWidth: .infinity, maxHeight: height)
                    .foregroundColor(item.color)
            }
            .ignoresSafeArea()
            .overlay(
                Circle().foregroundColor(.black)
                    .frame(height: height).aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                    .overlay(Image(systemName: item.icon)
                        .font(.title)
                        .foregroundColor(.white))
                , alignment: .bottom)
        }
    }
    
    struct TabContent<V: View>: View {
        @Binding var height: CGFloat
        @ViewBuilder var content: () -> V
        var body: some View {
            GeometryReader { gp in
                content()
                    .onAppear {
                        height = gp.safeAreaInsets.bottom
                    }
                    .onChange(of: gp.size) { _ in
                        height = gp.safeAreaInsets.bottom
                    }
            }
        }
    }
    
    struct Curve: Shape {
        func path(in rect: CGRect) -> Path {
            let h = rect.maxY * 0.7
            return Path {
                $0.move(to: .zero)
                $0.addLine(to: CGPoint(x: rect.midX / 2.0, y: rect.minY))
                $0.addCurve(to: CGPoint(x: rect.midX, y: h), control1: CGPoint(x: rect.midX * 0.8, y: rect.minY), control2: CGPoint(x: rect.midX * 0.7, y: h))
                $0.addCurve(to: CGPoint(x: rect.midX * 3.0 / 2.0, y: rect.minY), control1: CGPoint(x: rect.midX * 1.3, y: h), control2: CGPoint(x: rect.midX * 1.2, y: rect.minY))
                $0.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            }
        }
    }
}

struct TestReorderTabItemsPerSelection_Previews: PreviewProvider {
    static var previews: some View {
        TestReorderTabItemsPerSelection()
    }
}
