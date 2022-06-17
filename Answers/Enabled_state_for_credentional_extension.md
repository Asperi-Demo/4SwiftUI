```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to check whether user has enabled/checked autofill credential provider extension or not from phone settings in iOS? (by Ramzan)

A: As documented we need to use `ASCredentialIdentityStore` state for that purpose:

![cIuaa](https://user-images.githubusercontent.com/62171579/174344913-b38cde29-28ca-436b-89c6-479735ac7678.png)

so you can add somewhere the following wrapped async call and use it to validate of extension is enabled:

```
- (void)checkExtesionEnabledWithCompletion:(void(^)(BOOL))completion {
	ASCredentialIdentityStore *store = [ASCredentialIdentityStore sharedStore];
	[store getCredentialIdentityStoreStateWithCompletion:^(ASCredentialIdentityStoreState * _Nonnull state) {
		completion(state.isEnabled);
	}];
}
```
