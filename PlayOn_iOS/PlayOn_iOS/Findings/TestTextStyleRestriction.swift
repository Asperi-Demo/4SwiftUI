// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION:     By using this you agree do not repost any part of this code
//                    on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestTextStyleRestriction: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct TestTextStyleRestriction_Previews: PreviewProvider {
    static var previews: some View {
        TestTextStyleRestriction()
    }
}

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 34, weight: .bold))
    }
}

struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
      content
    }
}

protocol TextStyle {}

extension Text: TextStyle {}
extension TextEditor: TextStyle {}

extension View where Self: TextStyle {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

func ExpandingTextEditor<Style: ViewModifier>(text: Binding<String>, style: Style) -> some View {
    ZStack {
        TextEditor(text: text)
            .textStyle(style)

        Text(text.wrappedValue)
            .textStyle(style)
            .opacity(0)
            .padding(.all, 8)
    }
}

extension ViewModifier where Self == TitleStyle {
	static var title: TitleStyle { TitleStyle() }
}

extension ViewModifier where Self == BodyStyle {
	static var body: BodyStyle { BodyStyle() }
}

struct Demo_Previews: PreviewProvider {
	static var previews: some View {
		Text("Demo")
			.textStyle(.title)
	}
}
