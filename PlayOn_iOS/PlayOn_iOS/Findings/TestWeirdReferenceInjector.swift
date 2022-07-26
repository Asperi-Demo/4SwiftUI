// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestWeirdReferenceInjector: View {

	init() {
		var mary: ParentObject? = ParentObject()
		var tom: ChildObject? = ChildObject()

		// Original test-case: cross-dependency !!
		mary?.child = tom!
		tom?.parent = mary!

		// When settings the Parent and Child to nil,
		// both are expected to be deallocating.
		mary = nil
		tom = nil
	}
	
	var body: some View {
		Text("Nothing here")
	}
}

protocol ParentProtocol: AnyObject {}  // << important - must be reference type !!
class ParentObject: ParentProtocol {

	//var child: Child?
	@Injected(\.child) var child

	init() { print("🔔 Allocating Parent in memory") }
	deinit { print ("♻️ Deallocating Parent from memory") }
}

protocol ChildProtocol: AnyObject {}  // << important - must be reference type !!
class ChildObject: ChildProtocol {

	//weak var parent: Parent?
	@Injected(\.parent) var parent

	init() { print("🔔 Allocating Child in memory") }
	deinit { print("♻️ Deallocating Child from memory") }
}

protocol InjectedKeyProtocol {
	associatedtype Value
	static var currentValue: Self.Value? { get set }
}

// The main dependency injection custom tool.
@propertyWrapper
struct Injected<T> {

	private let keyPath: WritableKeyPath<InjectedDependency, T?>

	var wrappedValue: T? {
		get { InjectedDependency[keyPath] }
		set { InjectedDependency[keyPath] = newValue }
	}

	init(_ keyPath: WritableKeyPath<InjectedDependency, T?>) {
		self.keyPath = keyPath
	}
}

// The custom tool to use in unit tests to implement the mock
// within the associated WritableKeyPath.
struct InjectedDependency {

	private static var current = InjectedDependency()

	static subscript<K>(key: K.Type) -> K.Value? where K: InjectedKeyProtocol {
		get { key.currentValue }
		set { key.currentValue = newValue }
	}

	static subscript<T>(_ keyPath: WritableKeyPath<InjectedDependency, T?>) -> T? {
		get { current[keyPath: keyPath] }
		set { current[keyPath: keyPath] = newValue }
	}
}

// The Parent and Child keys to access the object in memory.
extension InjectedDependency {
	var parent: ParentProtocol? {
		get { Self[ParentKey.self] }
		set { Self[ParentKey.self] = newValue }
	}

	var child: ChildProtocol? {
		get { Self[ChildKey.self] }
		set { Self[ChildKey.self] = newValue }
	}
}

// The instantiation of the value linked to the key.
struct ParentKey: InjectedKeyProtocol {
	static weak var currentValue: ParentProtocol?  // << important - must be WEAK !!
}

struct ChildKey: InjectedKeyProtocol {
	static weak var currentValue: ChildProtocol?  // << important - must be WEAK !!
}

struct TestWeirdReferenceInjector_Previews: PreviewProvider {
	static var previews: some View {
		TestWeirdReferenceInjector()
	}
}
