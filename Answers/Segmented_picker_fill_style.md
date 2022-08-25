>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Set segment equal width for SwiftUI Picker with SegmentedPickerStyle (by user25917)

A: SwiftUI uses default macOS NSSegmetedControl behavior

```
@property NSSegmentDistribution segmentDistribution API_AVAILABLE(macos(10.13)); 
// Defaults to NSSegmentDistributionFill on 10.13, older systems will continue to behave similarly to NSSegmentDistributionFit
```

To change it here is a possible workaround, based on found `NSSegmentedControl` in run-time view hierarchy. 

![mCZu7](https://user-images.githubusercontent.com/62171579/186727403-38219380-6e8b-44db-8da5-d7695da7c28c.png)

**Disclaimer: Actually it is safe, ie. no crash in run-time, but can stop working in future returning to default behavior.**

So, the idea is to inject `NSView` via representable into view hierarchy above (!!) `Picker`, as

```
Picker(selection: $store.utility.saliencyType, label: EmptyView()) {
        ForEach(Store.Utility.SaliencyType.allCases, id: \.self) { saliencyType in
            Text(saliencyType.text)
                .tag(saliencyType)
        }
    }
    .overlay(NSPickerConfigurator {                // << here !!
        $0.segmentDistribution = .fillEqually // change style !!
    })
    .pickerStyle(SegmentedPickerStyle())
```

and configurator itself

```
struct NSPickerConfigurator: NSViewRepresentable {
    var configure: (NSSegmentedControl) -> Void

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            if let holder = view.superview?.superview {
                let subviews = holder.subviews
                if let nsSegmented = subviews.first?.subviews.first as? NSSegmentedControl {
                    self.configure(nsSegmented)
                }
            }
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
    }
}
```
