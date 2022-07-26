// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

//* { <<  Taken from https://forums.swift.org/t/getting-keypaths-to-members-automatically-using-mirror/21207/4
protocol DefaultValueProvider
{
	init()
}

protocol KeyPathListable : DefaultValueProvider
{
	static var allKeyPaths: [String : AnyKeyPath] { get }
}

fileprivate var _membersToKeyPaths: [String: AnyKeyPath]?

extension KeyPathListable
{
	private subscript(checkedMirrorDescendant key: String) -> Any
	{
		return Mirror(reflecting: self).descendant(key)!
	}

	static var allKeyPaths: [String : AnyKeyPath]
	{
		if _membersToKeyPaths == nil
		{
			_membersToKeyPaths = [String: PartialKeyPath<Self>]()

			let mirror = Mirror(reflecting: Self())

			for case (let key?, _) in mirror.children
			{
				_membersToKeyPaths![key] = \Self.[checkedMirrorDescendant: key] as PartialKeyPath
			}
		}

		return _membersToKeyPaths!
	}
}
//* >> }

@dynamicMemberLookup
struct WaterPointModel: Identifiable, KeyPathListable {

	init() {
		AQWFrTo = .zero
	}

	init(AQWFrTo: Double) {
		self.AQWFrTo = AQWFrTo
	}

	let id = UUID()
	let AQWFrTo: Double

	subscript(dynamicMember member: String) -> Double {
		let properties = ["abc": \Self.AQWFrTo]
		guard let kp = properties[member] else { return 0 }
		return self[keyPath: kp]
	}

}

struct TestWays4DynamicMemberLookup: View {
	var body: some View {
		Text("Test").onAppear { foo() }
	}

	// tested and all included cases worked
	func foo() {
		let a = WaterPointModel(AQWFrTo: 21.0)
		print("Original: \(a.abc)")

		// access via direct known property key-path
		let aqWFrTo = sumOnAttributeUSList([a], sumField: \.AQWFrTo)
		print("Direct: \(aqWFrTo)")

		// access via indirect known arbitrary key-path
		let aqWFrTo1 = sumOnAttributeUSList([a], sumField: \.abc)
		print("Remapped: \(aqWFrTo1)")

		// access via arbitrary property name
		let abc = "AQWFrTo"
		let aqWFrTo2 = sumOnAttributeUSList([a], sumField: abc)
		print("Mirrored: \(aqWFrTo2)")
	}

	func sumOnAttributeUSList(_ values:[WaterPointModel], sumField: KeyPath<WaterPointModel,Double>) -> Double {
		return values.map({ $0[keyPath:sumField] }).reduce(0, +)
	}

	func sumOnAttributeUSList(_ values:[WaterPointModel], sumField: String) -> Double {
		return values.map({ $0[keyPath: WaterPointModel.allKeyPaths[sumField] ??
		\WaterPointModel.fake] as! Double }).reduce(0, +)
	}
}

struct TestWays4DynamicMemberLookup_Previews: PreviewProvider {
	static var previews: some View {
		TestWays4DynamicMemberLookup()
	}
}
