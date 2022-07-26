```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Is is possible on iPad OS to detect if the keyboard is in floating mode? (by Ben)

A: There is no such mode enum/indicator (at least for now), but having keyboard frame information

>     public class let keyboardFrameBeginUserInfoKey: String // NSValue of CGRect
>     public class let keyboardFrameEndUserInfoKey: String // NSValue of CGRect

in corresponding keyboard notifications

>     public class let keyboardWillShowNotification: NSNotification.Name
> 
>     public class let keyboardDidShowNotification: NSNotification.Name
> 
>     public class let keyboardWillHideNotification: NSNotification.Name
> 
>     public class let keyboardDidHideNotification: NSNotification.Name
> 
>     public class let keyboardWillChangeFrameNotification: NSNotification.Name
> 
>     public class let keyboardDidChangeFrameNotification: NSNotification.Name


relative to screen bounds

    UIScreen.main.bounds

it is possible to detect if the frame of keyboard is at the edge of screen bottom or floating.

Schematically it would be like

    keyboardAttached = NSMaxX(screenBounds) == NSMaxX(keyboardFrame) &&
        NSMaxY(screenBounds) == NSMaxY(keyboardFrame) && 
        NSWidth(screenBounds) == NSWidth(keyboardFrame)
        
