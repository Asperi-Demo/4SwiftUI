// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import AVKit
import Combine

struct TestAVPlayerControllerFullScreen: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@State private var player = AVPlayer(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")!)

		var body: some View {
			VStack{
				AVPlayerControllerRepresentable(player: $player)
					.ignoresSafeArea()
					.frame(width: 290, height: 220)
			}.onAppear(){
				self.player.play();
			}
		}
	}

	struct AVPlayerControllerRepresentable: UIViewControllerRepresentable {
		@Binding var player: AVPlayer

		func makeUIViewController(context: UIViewControllerRepresentableContext<AVPlayerControllerRepresentable>) -> AVPlayerViewController {
			let controller  = AVPlayerViewController()
			controller.player = player
			controller.showsPlaybackControls = false;

			context.coordinator.playerController = controller
			return controller
		}

		func updateUIViewController(_  uiViewController: AVPlayerViewController , context: UIViewControllerRepresentableContext<AVPlayerControllerRepresentable>) {
		}

		class Coordinator: NSObject, AVPlayerViewControllerDelegate {
			weak var playerController: AVPlayerViewController? {
				didSet {
					playerController?.delegate = self
				}
			}

			private var subscriber: AnyCancellable? = nil
			override init() {
				super.init()
				subscriber = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
					.sink { [weak self] _ in
						self?.rotated()
					}
			}

			func rotated() {
				if UIDevice.current.orientation.isLandscape {
					self.enterFullScreen(animated: true)
				} else {
					self.exitFullScreen(animated: true)
				}
			}

			func enterFullScreen(animated: Bool) {
				print("Enter full screen")
				playerController?.perform(NSSelectorFromString("enterFullScreenAnimated:completionHandler:"), with: animated, with: nil)
			}

			func exitFullScreen(animated: Bool) {
				print("Exit full screen")
				playerController?.perform(NSSelectorFromString("exitFullScreenAnimated:completionHandler:"), with: animated, with: nil)
			}

			func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {

				// The system pauses when returning from full screen, we need to 'resume' manually.
				coordinator.animate(alongsideTransition: nil) { transitionContext in
					self.playerController?.player?.play()
				}
			}
		}

		func makeCoordinator() -> Coordinator {
			Coordinator()
		}
	}

}

struct TestAVPlayerControllerFullScreen_Previews: PreviewProvider {
	static var previews: some View {
		TestAVPlayerControllerFullScreen()
	}
}
