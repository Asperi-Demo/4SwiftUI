// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

/// A preference key to store ScrollView offset
public struct ViewOffsetKey: PreferenceKey {
    public typealias Value = CGFloat
    public static var defaultValue = CGFloat.zero
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

/// A preference key to store a view's height or width
public struct ViewSideLengthKey: PreferenceKey {
    public typealias Value = CGFloat
    public static var defaultValue: CGFloat = .zero
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

/// A preference key to store a view's rect
public struct ViewSizeKey: PreferenceKey {
    public typealias Value = CGSize
    public static var defaultValue = CGSize.zero
    public static func reduce(value: inout Value, nextValue: () -> Value) {
    }
}

/// A preference key to store a view's rect
public struct ViewRectKey: PreferenceKey {
    public typealias Value = Array<CGRect>
    public static var defaultValue = [CGRect]()
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

/// A preference key to store a view's point
public struct ViewPointKey: PreferenceKey {
    public typealias Value = Array<CGPoint>
    public static var defaultValue = [CGPoint]()
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
