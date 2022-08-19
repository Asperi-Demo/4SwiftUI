// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

#if canImport(Charts)
@available (iOS 16, *)
struct TestMenuCheckmarkInToolbar: View {
    enum SortOrder: String, CaseIterable, Identifiable {
        case forward
        case reverse
        
        var id: Self {
            self
        }
        
        static let `default`: Self = .forward
        
        var label: String {
            switch self {
            case .forward: return "Sort (forward)"
            case .reverse: return "Sort (reverse)"
            }
        }
    }
    
    @AppStorage("sortOrder") var sortOrder: SortOrder = .default {
        didSet {
            sort()
        }
    }
    
    
    @State private var items = ["foo", "bar", "baz"]
    
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem {
            Menu {
                ForEach(SortOrder.allCases) { sortOrder in
                    Button {
                        withAnimation { self.sortOrder = sortOrder }
                    } label: {
                        if sortOrder == self.sortOrder {
                            Label(sortOrder.label, systemImage: "checkmark")
                        } else {
                            Text(sortOrder.label)
                        }
                    }
                }
            } label: {
                Label("Actions", systemImage: "ellipsis.circle")
            }
            .id(self.sortOrder)     // << workaround !!
        }
    }
    
    var body: some View {
        NavigationStack {
            List(items, id: \.self) { item in
                Text(item)
            }
            .navigationTitle("Test")
            .toolbar { toolbar }
            .onAppear(perform: sort)
        }
    }
    
    func sort() {
        switch sortOrder {
        case .forward:
            items.sort(by: <)
        case .reverse:
            items.sort(by: >)
        }
    }
}

@available(iOS 16, *)
struct TestMenuCheckmarkInToolbar_Previews: PreviewProvider {
    static var previews: some View {
        TestMenuCheckmarkInToolbar()
    }
}
#endif
