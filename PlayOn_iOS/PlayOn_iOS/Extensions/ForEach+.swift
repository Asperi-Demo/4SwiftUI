// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

/// Helper extension to simplify ForEach construction with dictionaries
extension ForEach where Content : View {
/**
	Helper constructor for flat dictionary mapping to views

		var dictionary : [String: String] = [:]
		// ...
		ForEach(dictionary) {
		  Text($0 + $1)
		}
 */
	init<T>(_ dict: Dictionary<ID, T>, @ViewBuilder content: @escaping ((ID, T)) -> Content) where Data == [(ID, T)] {
		self.init(dict.map { ($0, $1) }, id: \.0, content: content)
	}

/**
	Helper constructor for key-sorted dictionary mapping to views

		var dictionary : [String: String] = [:]
		// ...
		ForEach(sorted: dictionary) {
		  Text($0 + $1)
		}
 */
	init<T>(sorted dict: Dictionary<ID, T>, @ViewBuilder content: @escaping ((ID, T)) -> Content) where Data == [(ID, T)], ID: Comparable {
		self.init(dict.sorted { $0.key > $1.key }, id: \.0, content: content)
	}
}

