```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Why is the inclusive range operator throwing an error when the exclusive operator does not? (by John)

A: Yes, there is a difference:

For `Range<Int>` (`..<`) operator there is explicit extension of `ForEach` which specifies associated types

>     @available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
>     extension ForEach where Data == Range<Int>, ID == Int, Content : View {

whereas for `ClosedRange<Int>` (`...`) there is no such, and it is considered as collection by more generic

>     /// A structure that computes views on demand from an underlying collection of
>     /// of identified data.
>     @available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
>     public struct ForEach<Data, ID, Content> where Data : RandomAccessCollection, ID : Hashable {

so requires explicit providing of ID type as below

    ForEach(0...2, id: \.self) {

or you can declare your own extension

    extension ForEach where Data == ClosedRange<Int>, ID == Int, Content : View {
        public init(_ data: ClosedRange<Int>, @ViewBuilder content: @escaping (Int) -> Content) {
            self.init(data, id: \.self, content: content)
        }
    }

and then just use

    ForEach(0...2) {

