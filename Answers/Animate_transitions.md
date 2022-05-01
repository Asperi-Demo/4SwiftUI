```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to animate transition between views in SwiftUI? (by cakeheart)

A: With the following approach you can modify your `appMode` as you wish (onAppear, onTapGesture, etc.). Animation duration is, of course, can be set any you wish (as well as kind of transition, actually, however some transitions behaves bad in Preview, and should be tested on Simulator or real device).

**Demo:** (first blink is just Preview launch, then two transitions for onAppear, then for onTap)

![ty3R6](https://user-images.githubusercontent.com/62171579/166143815-1460a483-a1ac-4cd6-a4e2-8774707a7051.gif)

Tested with Xcode 11.4 / iOS 13.4 - works and in Preview and in Simulator.

**Code:** Important parts marked with comments inline.

```swift
var body: some View {
    ZStack {
        // !! to keep background deepest, `cause it affects removing transition
        Color.blue.zIndex(-1)

        // !! keep any view in explicit own `if` (don't use `else`)
        if .game == self.appStore.appMode {
            GameView()
                .transition(AnyTransition.scale.animation(.easeInOut(duration: 1)))
        }

        if .options == self.appStore.appMode {
            OptionsView()
                .transition(AnyTransition.scale.animation(.easeInOut(duration: 1)))
        }

        if .menu == self.appStore.appMode {
            MenuView()
                .transition(AnyTransition.scale.animation(.easeInOut(duration: 1)))
        }
    }
}
```

**Update:** for `.slide` (and probably other moving transitions) the change of state should be wrapped into explicit `withAnimation`, like below

```
withAnimation {
    self.appStore.appMode = new_mode_here
}
```

Note: these is one of transitions that is not supported by Preview - test in Simulator.

Example for transition like

```swift
    ...
    if .menu == self.appStore.appMode {
        Text("MenuView").frame(width: 300, height: 100).background(Color.red)
            .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity).animation(.easeInOut(duration: 1)))
    }
}
.onTapGesture {
    withAnimation {
        let next = self.appStore.appMode.rawValue + 1
        self.appStore.appMode = next > 2 ? .game : AppStore.AppMode(rawValue: next)!
    }
}

```

![Bikx0](https://user-images.githubusercontent.com/62171579/166143822-7b8e8798-ff44-41d7-b349-75dc2a407613.gif)

