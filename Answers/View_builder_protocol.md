```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Protocol that has method return type View (by Pavel Gatilov)

A: Here is a solution. 

### Update: Xcode 13.4 - now I would propose

```
protocol Builder {
    associatedtype T: View
    @ViewBuilder func buildView() -> T
}
```


### Original: Tested with Xcode 11.4 / iOS 13.4

```
protocol Builder {
    associatedtype T:View    // << not exact, but just a View !!
    func viewForItem() -> T
}

struct ItemPhoto { // << just for testing
}

extension ItemPhoto: Builder {

    public func viewForItem() -> some View { // opaque !!
        Image("image.png").scaledToFit()
    }
}
```
