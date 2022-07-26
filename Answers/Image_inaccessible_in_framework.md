```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Images inaccessible from asset catalog in a my framework (by strangetimes)

A: By default

`Image("MyImage")` is `Image("MyImage", bundle: Bundle.main)`

ie. in bundle of application.

You have to explicitly specify bundle (of framework) in which Assets catalog is located, as

```Image("MyImage", bundle: bundle)```

where `bundle` is instantiated in usual way by class or identifier.
