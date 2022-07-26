```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```


Q: Instance member cannot be used on type in SwiftUI Preview (by gurehbgui)

A: It is due to `static var preview`, 

so use either `static` as well

```
struct DetailView_Previews: PreviewProvider {
    static var a = DataProvider.DataHeader(title: "a", text: "b")     // << here !!
    static var previews: some View {
        DetailView(header: a)
    }
}
```

or construct in place

```
DetailView(header: DataProvider.DataHeader(title: "a", text: "b"))
```
