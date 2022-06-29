// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

extension Section where Parent == Text, Content: View, Footer == EmptyView {
    init(_ title: LocalizedStringKey, content: @escaping () -> Content) {
        self.init(header: Text(title), content: content)
    }
}
