```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to get the index of a deleted row from a list in SwiftUI? (by Susca Bogdan)

A: If you remove by-one, then the following give you index of deleted row

```
func delete(at offsets: IndexSet) {     
      self.symptoms.remove(atOffsets: offsets)

      // here I want to make the HTTP request
      let index = offsets[offsets.startIndex]

      // ... use index in HTTP request
}
```
