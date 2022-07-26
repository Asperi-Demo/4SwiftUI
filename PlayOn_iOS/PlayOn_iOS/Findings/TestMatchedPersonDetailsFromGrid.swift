// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestMatchedPersonDetailsFromGrid: View {
	var body: some View {
		ContentView()
	}

	struct PersonDetails: View {
		@State var person:Person

		var body: some View {
			ZStack {

				Color.yellow

				HStack {
					Text("PERSON")
					Spacer()
				}

				Text(person.name)

				Spacer()

			}
			.border(.red)
		}
	}

	struct Person: Identifiable, Equatable {
		let id = UUID()
		let name: String
	}

	struct PersonView: View {
		let person: Person
		var body: some View {
			ZStack {
				Color.blue
				Text(person.name)
					.foregroundColor(.white)
			}
		}
	}

	struct ContentView: View {

		@Namespace private var gridSpace

		@State var persons = [Person(name: "A"), Person(name: "B"), Person(name: "C")]
		@State var selectedPerson:Person?

		let c = GridItem(.adaptive(minimum: 200, maximum: 400), spacing: 20)

		var body: some View {

			ZStack {
				ScrollView {
					LazyVGrid(columns: [c]) {
						ForEach(persons) { person in
							ZStack {
								if let selected = selectedPerson, selected == person {
									PersonView(person: person)
								} else {
									PersonView(person: person)
										.matchedGeometryEffect(id: person.id, in: gridSpace)
										.onTapGesture {
											if nil == selectedPerson {
												selectedPerson = person
											}
										}}

							}
							.frame(width: 100, height: 100)
						}
					}
				}
				VStack {   // << to remove fluently
					if let person = selectedPerson {
						PersonDetails(person: person)
							.matchedGeometryEffect(id: person.id, in: gridSpace)
							.transition(.scale(scale: 1))
							.frame(width: 360, height: 360)
							.onTapGesture {
								selectedPerson = nil
							}
					}
				}
				.animation(.default, value: selectedPerson)
			}
		}
	}
}

struct TestMatchedPersonDetailsFromGrid_Previews: PreviewProvider {
	static var previews: some View {
		TestMatchedPersonDetailsFromGrid()
	}
}
