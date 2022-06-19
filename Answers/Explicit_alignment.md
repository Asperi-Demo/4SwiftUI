```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Understanding the explicit alignment of SwiftUI (by Jay Lee)

A: 1) Alignment guides are present always. Container defines which alignment guides of internal views should be used by layout engine to align views within container. 

2) If you don't do anything with alignment guile's then implicit/default are used by layout engine. 

3) As soon as you use `.alignmentGuide()` modifier for view - you introduce explicit alignment guide

Here is an example of `ZStack` with top-leading alignment having two `Text` views.

**Default/implicit case:** both text aligned to top and left (top = 0, leading = 0), so Second just overlaps first (as this is ZStack).

![cNIvz](https://user-images.githubusercontent.com/62171579/174468257-ba035fae-4d2e-4cc4-9615-d69d5962e284.png)

```
struct DemoImplicitAlignment: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text("First").border(Color.green)
            Text("Second").border(Color.red)
        }
    }
}
```

**Explicit case:** we don't like overlapped texts and want second one be below & shifted as specified relative to first one.

![21pn9](https://user-images.githubusercontent.com/62171579/174468265-a806a712-aeb8-4c97-af87-fab19ee5cff5.png)

```
struct DemoExplicitAlignment: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text("First").border(Color.green)

            Text("Second").border(Color.red)
                // now my top alignment guide shifted from implicit/default one
                // on specified constant, so I have space above self
                .alignmentGuide(.top) { $0[.top] - 40 }
                // now my leading alignment guild shifted based on above
                // explicit own top alignment guide, so I have variation
                // free space ahead of self
                .alignmentGuide(.leading) { $0[explicit: .top]! / 2 }
        }
    }
}
```

And container, ie. ZStack, tight around most consumed intrinsic space, by default.

In the referenced topic you can find what can be done with just alignment guides [SwiftUI HStack with wrap and dynamic height](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/HStack_with_wrap_dynamic_height.md)
