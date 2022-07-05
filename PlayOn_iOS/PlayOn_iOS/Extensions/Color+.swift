// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION:     By using this you agree do not repost any part of this code
//                    on StackOverflow site. Thanks, Asperi.

import SwiftUI

extension Color {
    static let dynamicColor = Color(UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .black : .white
    })
}
