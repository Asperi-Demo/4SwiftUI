```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: snapshotView without subviews, or a way to access the subviews (by sch)

A: Here is simplified demo of possible approach (hide all subviews before snapshot and show right after done)

```
extension UIView {
    func snapshotMe() -> UIView? {
        _ = self.subviews.compactMap { $0.isHidden = true }
        defer {
            _ = self.subviews.compactMap { $0.isHidden = false }
        }
        return self.snapshotView(afterScreenUpdates: true)
    }
}
```

of course if your view subviews might be in already mixed hidden/visible state then in provided above extension you have to filter visible only subview in advance.
