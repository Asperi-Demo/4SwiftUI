// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import SpriteKit

struct TestInterceptMouseDownSKScene: View {
    
    class MyScene : SKScene {
        override func mouseDown(with event: NSEvent) {
            print(event)
        }
    }
    
    var scene : MyScene {
        let r = MyScene()
        r.isUserInteractionEnabled = true
        r.size = .init(width: 500, height: 500)
        r.scaleMode = .aspectFill
        r.backgroundColor = .orange
        return r
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: 500, height: 500)
            .padding()
    }
}

struct TestInterceptMouseDownSKScene_Previews: PreviewProvider {
    static var previews: some View {
        TestInterceptMouseDownSKScene()
    }
}
