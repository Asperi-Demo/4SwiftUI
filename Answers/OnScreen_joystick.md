```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: How to change the speed of drag based on distance already dragged? (by VladislavS)

A: Here is possible solution based on asymptotic curve (if somebody find it helpful). 

Tested with Xcode 11.4 / iOS 13.4

![30A37](https://user-images.githubusercontent.com/62171579/170769045-62c862dc-19d8-4545-8525-08c5c6ffd296.gif)

Main part:

    DragGesture().onChanged { value in
        let limit: CGFloat = 200        // the less the faster resistance 
        let xOff = value.translation.width
        let yOff = value.translation.height
        let dist = sqrt(xOff*xOff + yOff*yOff);
        let factor = 1 / (dist / limit + 1)
        self.dragValue = CGSize(width: value.translation.width * factor,
                            height: value.translation.height * factor)
        self.isDragging = true
    }

[Complete test module is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestScreenJoystick.swift)
