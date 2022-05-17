```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: UIDocumentPickerViewController not calling didPickDocumentAtURL on Mac Catalyst (by arlomedia)

A: As far as I see you've just made typo in method signature, the correct is

```objective-c
- (void)documentPicker:(UIDocumentPickerViewController *)controller 
didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls {
	NSLog(@"picked URLs %@", urls);
	// selecting multiple documents is cool, but requires iOS 11
	[self documentPicker:controller didPickDocumentAtURL:[urls firstObject]];
}
```

on iOS worked because deprecated legacy one still supported

```
- (void)documentPicker:(UIDocumentPickerViewController *)controller 
  didPickDocumentAtURL:(NSURL *)url; 
```

but macOS/Catalyst does not, so your delegate just not called due to absent method.

Tested and works with Xcode 11.2
