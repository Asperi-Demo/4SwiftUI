// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

extension Collection {
	/// Verifies if elements in collection are unique by requried element's property
	/// - Parameter key: KeyPath of property to be verified
	/// - Returns: true if all elements have same value by keypath, false otherwise.
	func isUnique<T: Hashable>(by key: KeyPath<Element, T>) -> Bool {
		var set = Set<T>()
		for value in self {
			set.insert(value[keyPath: key])
			if set.count > 1 { return false }
		}
		return true
	}
}
