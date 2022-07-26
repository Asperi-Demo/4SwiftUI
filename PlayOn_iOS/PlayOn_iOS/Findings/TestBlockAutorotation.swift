// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import SpriteKit

struct TestBlockAutorotation: View {

	class TestScene: SKScene {
		override func didMove(to view: SKView) {
			physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
		}

		override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
			guard let touch = touches.first else { return }

			let location = touch.location(in: self)
			let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
			box.position = location
			box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
			addChild(box)
		}
	}

    let scene: SKScene
    init() {
        let scene = TestScene()
        scene.size = CGSize(width: 300, height: 600)
        scene.scaleMode = .fill
        self.scene = scene
    }

	@State private var angle: Angle = .radians(0)

    var body: some View {
        	SpriteView(scene: scene)
				.frame(width: 300, height: 600)
            .rotationEffect(angle, anchor: .center)
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            		self.updateOrintation()
			}
			.onAppear {
				self.updateOrintation()
			}
            .edgesIgnoringSafeArea(.all)
    }

    private func updateOrintation() {
		switch UIDevice.current.orientation {
		case .landscapeLeft:
			self.angle = .radians(-.pi / 2)
		case .landscapeRight:
			self.angle = .radians(.pi / 2)
		case .portraitUpsideDown:
			self.angle = .radians(.pi)
		default:
			self.angle = .radians(0)
		}
	}
}

struct TestBlockAutorotation_Previews: PreviewProvider {
    static var previews: some View {
        TestBlockAutorotation()
    }
}
