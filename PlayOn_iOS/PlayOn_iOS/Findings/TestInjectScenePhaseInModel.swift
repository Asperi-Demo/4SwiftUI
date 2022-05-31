// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI
import Combine

struct TestInjectScenePhaseInModel: View {
	var body: some View {
		ContentView()
	}

	class Model {
		var scenePhase: ScenePhase?
		var timerSubscription: AnyCancellable?
		init() {
			timerSubscription = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
				if self.scenePhase == .background {
					// do something when the app goes to the background.
				}
				print(self.scenePhase != nil ? "\(self.scenePhase!)" : "Unknown") // print background while the app is in the foreground.
			}
		}
	}

	struct ContentView: View {
		@Environment(\.scenePhase) var scenePhase
		var model = Model()

		var body: some View {
			Text("Hello, world!")
				.padding()
				.onChange(of: scenePhase) {
					self.model.scenePhase = $0
				}
				.onAppear {
					self.model.scenePhase = scenePhase
				}
		}
	}
}

struct TestInjectScenePhaseInModel_Previews: PreviewProvider {
	static var previews: some View {
		TestInjectScenePhaseInModel()
	}
}
