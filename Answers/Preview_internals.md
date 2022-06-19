```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Streamlining SwiftUI Previews in Xcode (by Anton)

A: Practically Live-Preview mode run-time does not differ much from Simulator Debug mode run-time. And this, of course, as intended to give us quick (as possible) feedback of our code execution. 

Anyway here are some findings... that might be used as solution/workaround for some cases that detection of Preview is highly desirable.

So created from scratch SwiftUI Xcode template project and in all functions of generated entities add `print(#function)` instruction.

ContentView.swift
```
import SwiftUI

struct ContentView: View {
    init() {
        print(#function)
    }

    var body: some View {
        print(#function)
        return someView()
            .onAppear {
                print(#function)
            }
    }

    private func someView() -> some View {
        print(#function)
        return Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        print(#function)
        return ContentView()
    }
}
```

Perform *Debug Preview* and see output:

```
application(_:didFinishLaunchingWithOptions:)
application(_:configurationForConnecting:options:)
scene(_:willConnectTo:options:)
init()
sceneWillEnterForeground(_:)
sceneDidBecomeActive(_:)
2020-06-12 16:08:14.460096+0300 TestPreview[70945:1547508] [Agent] Received remote injection
2020-06-12 16:08:14.460513+0300 TestPreview[70945:1547508] [Agent] Create remote injection Mach transport: 6000026c1500
2020-06-12 16:08:14.460945+0300 TestPreview[70945:1547482] [Agent] No global connection handler, using shared user agent
2020-06-12 16:08:14.461216+0300 TestPreview[70945:1547482] [Agent] Received connection, creating agent
2020-06-12 16:08:15.355019+0300 TestPreview[70945:1547482] [Agent] Received message: < DTXMessage 0x6000029c94a0 : i2.0e c0 object:(__NSDictionaryI*) {
    "updates" : <NSArray 0x7fff8062cc40 | 0 objects>
    "id" : [0]
    "scaleFactorHint" : [3]
    "providerName" : "11TestPreview20ContentView_PreviewsV"
    "products" : <NSArray 0x600000fcc650 | 1 objects>
} > {
    "serviceCommand" : "forwardMessage"
    "type" : "display"
}
__preview__previews
init()
__preview__body
__preview__someView()
__preview__body
__preview__body
__preview__someView()
__preview__body
```

As it is clear complete workflow of app launching has been performed at start `AppDelegate > SceneDelegate > ContentView > Window` and **only after this** the *PreviewProvider* part.

And in this latter part we see something interesting - all functions of `ContentView` in Preview mode have **__preview** prefix (except init)!!

So, finally, here is possible workaround **(DISCLAIMER!!! - on your own risk - only demo)**

The following variant

```
struct ContentView: View {

    var body: some View {
        return someView()
            .onAppear {
                if #function.hasPrefix("__preview") {
                    print("Hello Preview!")
                } else {
                    print("Hello World!")
                }
            }
    }

    private func someView() -> some View {
        if #function.hasPrefix("__preview") {
            return Text("Hello Preview!")
        } else {
            return Text("Hello World!")
        }
    }
}
```

Gives this

![mOtEY](https://user-images.githubusercontent.com/62171579/174467717-b24ecca8-a60d-497c-b1c9-6f7a4dd756f7.png)

