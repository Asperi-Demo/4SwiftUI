// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION:     By using this you agree do not repost any part of this code
//                    on StackOverflow site. Thanks, Asperi.

import SwiftUI

#if canImport(Charts)
@available (iOS 16, *)
struct TestTwoLinksInRowNavigationStack: View {
    struct Tweet: Identifiable, Hashable {
        var id: String { userID }
        let userID = "1"
        let text = "Hello world!"
    }
    struct User: Identifiable, Hashable {
        let id = "1"
        let name = "Asperi"
        let color = Color.yellow
    }
    let tweets: [Tweet] = [Tweet()]
    let users: [User] = [User()]
    
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List(tweets) { tweet in
                let user = users.first { $0.id == tweet.userID }!
                
                HStack {
                    Image(systemName: "person")
                        .foregroundStyle(user.color)
                        .padding(4)
                        .highPriorityGesture(TapGesture().onEnded {
                            path.append(user)
                        })
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("@\(user.name)")
                        Text(tweet.text)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    path.append(tweet)
                }
                .swipeActions(edge: .leading) {
                    Button("Like") { }
                }
            }
            .navigationDestination(for: Tweet.self) { tweet in
                Text("TweetDetailView(tweet: \(tweet.text))")
            }
            .navigationDestination(for: User.self) { user in
                Text("UserDetailView(user: \(user.name))")
            }
        }
    }
}

@available (iOS 16, *)
struct TestTwoLinksInRowNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        TestTwoLinksInRowNavigationStack()
    }
}

#endif
