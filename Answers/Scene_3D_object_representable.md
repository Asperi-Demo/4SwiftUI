```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to add 3D shapes in Swift UI?

A: Here is simplest code to demo how to setup SceneKit scene with your sphere. Hope it helps.

    import SwiftUI
    import SceneKit
    
    struct SceneKitView: UIViewRepresentable {
        func makeUIView(context: UIViewRepresentableContext<SceneKitView>) -> SCNView {
            let sceneView = SCNView()
            sceneView.scene = SCNScene()
            sceneView.allowsCameraControl = true
            sceneView.autoenablesDefaultLighting = true
            sceneView.backgroundColor = UIColor.black
    
            let sphere = SCNSphere(radius: 2.0)
            sphere.firstMaterial?.diffuse.contents = UIColor.blue
            let spherenode = SCNNode(geometry: sphere)
            spherenode.position = SCNVector3(x: 0.0, y: 3.0, z: 0.0)
    
            sceneView.scene?.rootNode.addChildNode(spherenode)
            return sceneView
        }
        
        func updateUIView(_ uiView: SCNView, context: UIViewRepresentableContext<SceneKitView>) {
            
        }
        
        typealias UIViewType = SCNView
    }
    
    struct DemoSceneKit: View {
        var body: some View {
            SceneKitView()
        }
    }
    
