```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to use "*.scnp" file in SwiftUI for button click (iOS)? (by J A S K I E R)

A: Here is modified code with demo. Tested with Xcode 11.4 / macOS 10.15.4

![EcR99](https://user-images.githubusercontent.com/62171579/174467874-c64fad80-5987-4515-af92-faac348aaacb.gif)

*Note: as I don't know your project structure, all dependent resource files were added as Resources (not in Assets). Just in case.*

![StDAx](https://user-images.githubusercontent.com/62171579/174467885-bb909a59-a449-47e1-8c4a-f81fc45bc1c9.png)


```
struct DemoSceneKitParticles: View {
    @State private var exploding = false
    var body: some View {
        VStack {
            ScenekitView(exploding: $exploding)
            Button("BOOM") { self.exploding = true }
        }
    }
}

struct ScenekitView : NSViewRepresentable {
    @Binding var exploding: Bool
    let scene = SCNScene(named: "ship.scn")!

    func makeNSView(context: NSViewRepresentableContext<ScenekitView>) -> SCNView {
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)

        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)

        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)

        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = NSColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)

        // retrieve the ship node
        let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!

        // animate the 3d object
        ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))

        // retrieve the SCNView
        let scnView = SCNView()
        return scnView
    }

    func updateNSView(_ scnView: SCNView, context: Context) {
        scnView.scene = scene

        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true

        // show statistics such as fps and timing information
        scnView.showsStatistics = true

        // configure the view
        scnView.backgroundColor = NSColor.black

        if exploding {
            if let ship = scene.rootNode.childNode(withName: "ship", recursively: true),
                let particles = SCNParticleSystem(named: "Explosion", inDirectory: nil) {

                let node = SCNNode()
                node.addParticleSystem(particles)
                node.position = ship.position
                scnView.scene?.rootNode.addChildNode(node)
                ship.removeFromParentNode()
            }
        }
    }
}
```


**Update: variant for iOS**

Tested with Xcode 11.4 / iOS 13.4

![IwsCl](https://user-images.githubusercontent.com/62171579/174467894-3fd09fc1-76d4-4960-bb87-26842dd1e88d.gif)

Full module code (resource files as before at top level)

```
import SwiftUI
import SceneKit

struct DemoSceneKitParticles: View {
    @State private var exploding = false
    var body: some View {
        VStack {
            ScenekitView(exploding: $exploding)
            Button("BOOM") { self.exploding = true }
        }
    }
}

struct ScenekitView : UIViewRepresentable {
    @Binding var exploding: Bool
    let scene = SCNScene(named: "ship.scn")!

    func makeUIView(context: Context) -> SCNView {
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)

        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)

        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)

        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)

        // retrieve the ship node
        let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!

        // animate the 3d object
        ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))

        // retrieve the SCNView
        let scnView = SCNView()
        return scnView
    }

    func updateUIView(_ scnView: SCNView, context: Context) {
        scnView.scene = scene

        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true

        // show statistics such as fps and timing information
        scnView.showsStatistics = true

        // configure the view
        scnView.backgroundColor = UIColor.black

        if exploding {
            if let ship = scene.rootNode.childNode(withName: "ship", recursively: true),
                let particles = SCNParticleSystem(named: "Explosion", inDirectory: nil) {

                let node = SCNNode()
                node.addParticleSystem(particles)
                node.position = ship.position
                scnView.scene?.rootNode.addChildNode(node)
                ship.removeFromParentNode()
            }
        }
    }
}
```
