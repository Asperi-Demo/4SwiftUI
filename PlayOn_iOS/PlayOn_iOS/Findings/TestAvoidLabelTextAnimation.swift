// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestAvoidLabelTextAnimation: View {
	var body: some View {
		AirTabStack(
			tabs: [
				.init(title: "Today", imageName: "car"),
				.init(title: "Journal", imageName: "bus"),
				.init(title: "Settings", imageName: "airplane")
			],
			actions: [
				.init(title: "", imageName: "icon.plus") {
					print("Hello")
				}
			]
		)
		.padding(.horizontal, 20)
	}
}

struct TabModel: Identifiable {

	let id = UUID()

	var title: String
	var imageName: String

}

struct TabActionModel: Identifiable {

	let id = UUID()

	var title: String
	var imageName: String
	var action: () -> ()

}

struct AirTabActionView: View {

	var model: TabActionModel

	var body: some View {
		HStack(spacing: 10) {
			Image(systemName: model.imageName)
				.foregroundColor(.accentColor)
			if !model.title.isEmpty {
				Text(model.title)
					.font(.subheadline)
					.fontWeight(.medium)
					.foregroundColor(.init(uiColor: .label))
			}
		}
		.padding(10)
		.onTapGesture(perform: model.action)
	}

}

struct AirTabView: View {

	@Binding var isActive: Bool

	var model: TabModel
	var action: (() -> ())

	var body: some View {
		HStack(spacing: 10) {
			if isActive {
				HStack {
					Image(systemName: model.imageName)
						.foregroundColor(.black)
					Text(model.title)
						.font(.subheadline)
						.fontWeight(.medium)
						.foregroundColor(.init(uiColor: .label)
						)
						.lineLimit(1)
				}.transition(.identity)
			} else {
				Image(systemName: model.imageName)
					.foregroundColor(.black).transition(.identity)
			}
		}
		.animation(.none, value: isActive)
		.padding(10)
		.background(isActive ? Color(.secondarySystemBackground) : .clear)
		.cornerRadius(11)
		.onTapGesture(perform: action)
		.animation(.linear(duration: 0.5), value: isActive)
	}
}

struct AirTabBar: View {

	var tabs: [TabModel]
	var actions: [TabActionModel]

	@State private var selectedIndex = 0

	var body: some View {
		HStack(spacing: 10) {
			ForEach(0..<tabs.count, id: \.self) { index in
				AirTabView(isActive: .constant(selectedIndex == index), model: tabs[index]) {
					selectedIndex = index
				}
			}
			Spacer()
			ForEach(0..<actions.count, id: \.self) { index in
				AirTabActionView(model: actions[index])
			}

		}
		.padding(.horizontal, 20)
		.padding(.vertical, 10)
		.background()
		.cornerRadius(16)
		.shadow(
			color: .init(uiColor: .black
				.withAlphaComponent(0.07)
			),
			radius: 15,
			x: 2)
	}

}

struct AirTabStack: View {

	var tabs: [TabModel]
	var actions: [TabActionModel]

	var body: some View {
		ZStack {
			VStack {
				Spacer()
				AirTabBar(tabs: tabs, actions: actions)
			}
		}
	}

}



struct TestAvoidLabelTextAnimation_Previews: PreviewProvider {
	static var previews: some View {
		TestAvoidLabelTextAnimation()
	}
}
