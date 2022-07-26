```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Keychain SecItemUpdate returning errSecParam (by WishIHadThreeGuns)

A: It should be specified class in query and not data (for update), so, for example, to add/update password in keychain it should be as following

```
// adding item
let addQuery: [CFString: Any] = [
	kSecClass: kSecClassGenericPassword,
	kSecAttrService: service as CFString,        // eg. "www.mysite.com"
	kSecAttrAccount: name as CFString            // eg. "user"
    kSecValueData: password.data(using: .utf8)   // eg. "password"
] as CFDictionary

if errSecSuccess != SecItemAdd(addQuery, nil) { 
    // report error here
}

// updating item (same query is for SecItemDelete)

let updateQuery: [CFString: Any] = [
	kSecClass: kSecClassGenericPassword,
	kSecAttrService: service as CFString,        // eg. "www.mysite.com"
	kSecAttrAccount: name as CFString            // eg. "user"
] as CFDictionary

let newAttributes = [
	kSecAttrAccount: newName as CFString            // eg. "user1"
    kSecValueData: newPassword.data(using: .utf8)   // eg. "password1"
] as CFDictionary

if errSecSuccess != SecItemUpdate(updateQuery, newAttributes) {
   // report error here
}
```
