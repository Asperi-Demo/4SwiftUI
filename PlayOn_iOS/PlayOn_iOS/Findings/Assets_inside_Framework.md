```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: iOS: How to add Assets folder inside a Framework and how to access them in code? (by Archie G. Quiñones)

A: Add *Asset catalog* to framework target as usual via *New File... > Resources*, but to get resource from such asset it needs to specify bundle explicitly, as in below example...

Assuming that `ImageProvider` is in framework target, the code could be 


    public class ImageProvider {
        // convenient for specific image
        public static func picture() -> UIImage {
            return UIImage(named: "picture", in: Bundle(for: self), with: nil) ?? UIImage()
        }
    
        // for any image located in bundle where this class has built
        public static func image(named: String) -> UIImage? {
            return UIImage(named: named, in: Bundle(for: self), with: nil)
        }
    }

of course you can name such class anyhow.
