// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestAsyncUpdateSelectionMatching: View {
	struct LeagueResponse: Decodable {
		var status: Bool?
		var data: [League] = []
	}

	struct League: Codable, Identifiable {
		let id: String
		let name: String
		var seasons: [Season]?

	}

	struct SeasonResponse: Codable {
		var status: Bool?
		var data: LeagueData?
	}

	struct LeagueData: Codable {
		let name: String?
		let desc: String
		let abbreviation: String?
		let seasons: [Season]
	}

	struct Season: Codable {
		let year: Int
		let displayName: String

	}

	class LeagueViewModel: ObservableObject {
		@Published var leagues: [League] = []

		init() {
			Task {
				try await getLeagueData()
			}
		}

		private func getLeagueData() async throws {
			let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api-football-standings.azharimm.site/leagues")!)
			guard let leagues = try? JSONDecoder().decode(LeagueResponse.self, from: data) else {
				throw URLError(.cannotParseResponse)
			}
			await MainActor.run {
				self.leagues = leagues.data
			}
		}

		func loadSeasons(forLeague id: String, completion: (([Season]) -> Void)?) async throws {
			let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api-football-standings.azharimm.site/leagues/\(id)/seasons")!)
			guard let seasons = try? JSONDecoder().decode(SeasonResponse.self, from: data) else {
				throw URLError(.cannotParseResponse)
			}
			await MainActor.run {
				if let responsedLeagueIndex = leagues.firstIndex(where: { $0.id == id }),
				   let unwrappedSeasons = seasons.data?.seasons {
					leagues[responsedLeagueIndex].seasons = unwrappedSeasons
					completion?(unwrappedSeasons)
					print(unwrappedSeasons) // successfully getting and parsing data
				}
			}
		}
	}

	@StateObject var vm = LeagueViewModel()

	var body: some View {
		NavigationView {
			VStack {
				if vm.leagues.isEmpty {
					ProgressView()
				} else {
					List {
						ForEach(vm.leagues) { league in
							NavigationLink(destination: DetailView(league: league)) {
								Text(league.name)
							}
						}
					}
				}
			}
			.navigationBarTitle(Text("Leagues"), displayMode: .large)
		}
		.environmentObject(vm)
	}

	struct DetailView: View {

		@EnvironmentObject var vm: LeagueViewModel
		@State var league: League

		var body: some View {
			VStack {
				if let unwrappedSeasons = league.seasons {
					List {
						ForEach(unwrappedSeasons, id: \.year) { season in
							Text(season.displayName)
						}
					}
				} else {
					ProgressView()
				}
			}
			.task(id: league.id) {
				Task {
					try await vm.loadSeasons(forLeague: league.id) {
						league.seasons = $0
					}
				}
			}
			.navigationBarTitle(Text("League Detail"), displayMode: .inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					ChangeButton(selectedLeague: $league)
				}
			}
		}
	}
	
	struct ChangeButton: View {

		@EnvironmentObject var vm: LeagueViewModel
		@Binding var selectedLeague: League // if remove @State the data will pass fine

		var body: some View {
			Menu {
				ForEach(vm.leagues) { league in
					Button {
						self.selectedLeague = league
					} label: {
						Text(league.name)
					}
				}
			} label: {
				Image(systemName: "calendar")
			}
		}
	}
}
struct TestAsyncUpdateSelectionMatching_Previews: PreviewProvider {
	static var previews: some View {
		TestAsyncUpdateSelectionMatching()
	}
}
