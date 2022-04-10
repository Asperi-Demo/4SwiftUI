```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Access generic property in sub class in Swift (by Mike.R)

A: There is no type `Child` for your case, because `Child<Element1>` 
differs from `Child<Element2>` in the same way as `ChildElement1` would 
differ from `ChildElement2` (assuming both are subclass of `Parent`).

So in the case of usage generics you have to continue use generics in 
places where you want to access corresponding properties, for example:

```
func accesChildProp<E: View>(_ obj: Child<E>) -> some View {
  return obj.someProp
}
```
