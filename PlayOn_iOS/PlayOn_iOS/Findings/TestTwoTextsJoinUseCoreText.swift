// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTwoTextsJoinUseCoreText: View {
    var body: some View {
        VStack {
            // assume we have restricted box to fit two aligned texts
            // into it so it looks like one and the first text is cut
            // with ellipsis if overlaps second
            let size = CGSize(width: 200, height: 60)

            TextBox(size: size, text: Lorem.long, ending: "$999")
                .border(.black)
            TextBox(size: size, text: Lorem.short, ending: "$999")
                .border(.black)
            TextBox(size: size, text: "One line", ending: "$999")
                .border(.black)
        }
    }
}

import CoreText

struct TextBox: View {
//    @ScaledMetric var scale: CGFloat = 1
    @State private var text: String
    @State private var bounds: CGRect?

    private var ending: String
    private var size: CGSize

    init(size: CGSize, text: String, ending: String) {
        self.size = size
        self._text = State(initialValue: text)
        self.ending = ending
    }

    var body: some View {
        ZStack(alignment: rootAlignment) {
            Text(calculate(text, ending, CGRect(origin: .zero, size: size)))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(ending)
                .bold().foregroundColor(.red)
        }
        .frame(width: size.width, height: size.height, alignment: .trailing)
    }

    // try to detect part of main string that are not overlapped with second
    // string and cut it explicitly
    func calculate(_ text: String, _ suffix: String, _ bounds: CGRect?) -> String {
        guard let size = bounds?.size else { return text }
        
        // most undefinite - in general we cannot extract SwiftUI Text style !!
        let font = UIFont.preferredFont(forTextStyle: .body)

        let ending = NSAttributedString(string: suffix, attributes: [.font : font])
        let line = CTLineCreateWithAttributedString(ending)
        let rect = CTLineGetBoundsWithOptions(line, [])
        
        // a non-square text area to exclude region of mixed-in suffix text
        let path = Path {
// 1) to test full external rect
//            $0.addRect(CGRect(origin: .zero, size: size))
            $0.move(to: .zero)
            $0.addLine(to: CGPoint(x: size.width, y: 0))
            $0.addLine(to: CGPoint(x: size.width, y: size.height - rect.height))
            $0.addLine(to: CGPoint(x: size.width - rect.width, y: size.height - rect.height))
            $0.addLine(to: CGPoint(x: size.width - rect.width, y: size.height))
            $0.addLine(to: CGPoint(x: 0, y: size.height))
            $0.addLine(to: CGPoint(x: 0, y: 0))
        }

        let string = NSAttributedString(string: text, attributes: [.font : font])
        let frameSetter = CTFramesetterCreateWithAttributedString(string as CFAttributedString)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path.cgPath, nil)

        // here is an assumption that CoreText layout fits SwiftUI layout, so
        // cut string in framesetter is the same as cut string in Text
        let length = CTFrameGetVisibleStringRange(frame).length
        if length != 0, length < text.count {
            let end = text.index(text.startIndex, offsetBy: length - 1)
            return String(text[..<end]) + "…"
        }
        return text
    }

    private var rootAlignment: Alignment {
        if #available(iOS 16, *) {
#if canImport(Charts)
            return Alignment.trailingLastTextBaseline
#else
            return Alignment(horizontal: .trailing, vertical: .lastTextBaseline)
#endif
        } else {
            return Alignment(horizontal: .trailing, vertical: .lastTextBaseline)
        }
    }
    
    var experimental_body: some View {
        ZStack(alignment: rootAlignment) {
// 2) to test calculable bounds of Text only
//            Text(calculate(text, ending, bounds))
            Text(calculate(text, ending, CGRect(origin: .zero, size: size)))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
// 2) ...
//                .background(GeometryReader {
//                    Color.clear.preference(key: ViewRectKey.self,
//                            value: [$0.frame(in: .local)])
//                })
//                .onPreferenceChange(ViewRectKey.self) {
//                    bounds = $0.first
//                }
            Text(ending)
                .bold().foregroundColor(.red)
        }
        .frame(width: size.width, height: size.height, alignment: .trailing)
// 3) to reset on scaled metric changed
//        .onChange(of: scale) { _ in
//            bounds = nil
//        }
    }
}

struct TestTwoTextsJoinUseCoreText_Previews: PreviewProvider {
    static var previews: some View {
        TestTwoTextsJoinUseCoreText()
    }
}
