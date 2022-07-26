```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI View convenience initializers with `where` constraints (by kid_x)

A: The SwiftUI.ForEach does not use such initilizer, instead they specify explicitly for `Range<Int>`, because when you specify `indices` as a argument there is NO original collection type... but I think you want something like

```
extension SwiftUIView {
    init(data: T, selection: Binding<T.Element>, @ViewBuilder content: @escaping (T.Element) -> ElementView) 
      where T.Element == ID {
        self.init(data: data, id: \.self, selection: selection, content: content)
    }
}
```

Tested with Xcode 13.3 / iOS 15.4

on

```
VStack {
    // in such construction there is no Array<Int> anywhere to infer
    // from arguments, the T here is Range<Int>. The constant selection
    // is just for testing
    SwiftUIView(data: [1, 2, 3].indices, selection: .constant(0)) { 
       Text("\($0)")
    }
}
```

gives

![7ybBj](https://user-images.githubusercontent.com/62171579/164618060-d2b3859c-d955-4101-abe7-22e094da3504.png)

Complete [test module in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestConvenienceInitWithConstrains.swift)
