```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Objective-C Closure to use Swift enum (by ohglstr)

A: To be compatible with objective-c enum must be inherited from Int, like

    @objc public enum Status: Int {
        case unknown
        case ok
        case failed
    }

make sure generated bridge header file "YOURPROJECT-Swift.h" contains

    typedef SWIFT_ENUM(NSInteger, Status, closed) {
      StatusUnknown = 0,
      StatusOk = 1,
      StatusFailed = 2,
    };

then in your .m file

    #import "YOURPROJECT-Swift.h"
    
    ...
    
    + (void)fetch:(void (^_Nonnull)(Status success))completion
    {
        // do anything needed    
    }

Clean/Build - all compiled well. Tested with Xcode 11.2.

