// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

/// A preference key to store ScrollView offset
public struct ViewOffsetKey: PreferenceKey {
    public typealias Value = CGFloat
    public static var defaultValue = CGFloat.zero
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

/// A preference key to store a view's height
public struct ViewHeightKey: PreferenceKey {
    public static var defaultValue: CGFloat { 0 }
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
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
