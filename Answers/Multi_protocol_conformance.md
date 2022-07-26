```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Swift multi-protocol conformance, compilation error (by danylokos)

A: 

>     struct StructC: ProtoA, ProtoB {
>         var input: ProtoAInput & ProtoBInput { return self }
>     }

Instead of above you need something like the following

```
extension ProtoA where Self == StructC {
    var input: ProtoAInput { self }
}

extension ProtoB where Self == StructC {
    var input: ProtoBInput { self }
}

struct StructC: ProtoA, ProtoB {
}
```

Tested & worked with Xcode 12.1 / iOS 14.1

