```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to detect in runtime that app uses swift

A: Please find below the possible approach based on public documented `dyld` API available since iPhone2 and valid for all modern iOS versions. And `libswiftCore.dylib` is present always for swift.

Taking into account that Swift might be in some application plug-ins, the below function should be called regularly (or at least till first positive result) on your framework API call.

    #import <mach-o/dyld.h>
    
    BOOL isSwiftLoaded() {
        return NSVersionOfRunTimeLibrary("libswiftCore.dylib") != -1; 
                // -1 is documented indicator that library is not loaded
    }
