```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI List - Remote Image loading = images flickering (reloading) (by Radagast the Brown)

A: I would change the order of assigning as below (because otherwise `dataIsValid` force refresh, but `data` is not set yet)

    DispatchQueue.main.async {
        self.data = data             // 1) set data
        self.dataIsValid = true.     // 2) notify that data is ready

everything else does not seem important. However consider possibility to optimise below, because `UIImage` construction from data might be also long enough (for UI thread) 

    func imageFromData(_ data: Data) -> UIImage {
        UIImage(data: data) ?? UIImage()
    }

so I would recommend to move not only data, but entire image construction into background thread and refresh only when final image is ready.

**Update:** I've made your code snapshot work locally, with some replacements and simplifications of course, due to not all parts originally available, and proposed above fix. Here is some experimenting result:

![r8icc](https://user-images.githubusercontent.com/62171579/175863227-661dfa3a-31db-42d4-9ee7-ea6589ffb1c2.gif)

as you see no flickering is observed and no repeated logging in console. As I did not made any major changes in you code logic I assume the issue resulting in reported flickering is not in provided code - probably some other parts cause recreation of `ImaveView` that gives that effect.

Here is my code (completely, tested with Xcode 11.2/3 & iOS 13.2/3):

    struct ImageView: View {
        @ObservedObject var imageLoader: ImageLoaderNew
        @State var image: UIImage = UIImage()
    
        init(withURL url: String) {
            imageLoader = ImageLoaderNew(urlString: url)
        }
    
        func imageFromData(_ data: Data) -> UIImage {
            UIImage(data: data) ?? UIImage()
        }
    
        var body: some View {
            VStack {
                Image(uiImage: imageLoader.dataIsValid ?
                    imageFromData(imageLoader.data!) : UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:60, height:60)
                    .background(Color.gray)
            }
        }
    }
    
    class ImageLoaderNew: ObservableObject
    {
        @Published var dataIsValid = false
        var data: Data?
    
        // The dispatch fires over and over again. No idea why yet
        // this causes flickering of the images in the List.
        // I am only loading a total of 3 items.
    
        init(urlString: String) {
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.data = data
                    self.dataIsValid = true
                    print(response?.url as Any) // prints over and over again.
                }
            }
            task.resume()
        }
    }
    
    struct TestImageFlickering: View {
        @State private var results: [String] = []
        var body: some View {
            NavigationView {
                List(results, id: \.self) { item in
                    HStack {
                        
                        // All of these image end up flickering
                        // every few seconds or so.
                        ImageView(withURL: item)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                        
                        VStack(alignment: .leading) {
                            Text("trackName")
                                .foregroundColor(.gray)
                                .font(.headline)
                                .truncationMode(.middle)
                                .lineLimit(2)
                            
                            Text("collectionName")
                                .foregroundColor(.gray)
                                .font(.caption)
                                .truncationMode(.middle).lineLimit(1)
                        }
                    }
                }
                .frame(height: 200.0)
                .onAppear(perform: loadData)
            } // Only happens once
        }
        
        func loadData() {
            var urls = [String]()
            for i in 1...10 {
                urls.append("https://placehold.it/120.png&text=image\(i)")
            }
            self.results = urls
        }
    }
    
