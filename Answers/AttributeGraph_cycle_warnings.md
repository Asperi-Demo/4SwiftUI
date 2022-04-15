```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How do I debug SwiftUI AttributeGraph cycle warnings? (by Sindre Sorhus)

A: The log is generated by (from private *AttributeGraph.framework*)

```
AG::Graph::print_cycle(unsigned int) const ()
```

so you can set symbolic breakpoint for `print_cycle`

![xicK9](https://user-images.githubusercontent.com/62171579/163404010-704e8025-a512-4249-8805-c598433a8f20.png)


and, well, how much it could be helpful depends on your scenario, but definitely you'll get error generated stack in Xcode.

the symbol has been found with help of Terminal command

```
$ nm /System/Library/PrivateFrameworks/AttributeGraph.framework/AttributeGraph
```