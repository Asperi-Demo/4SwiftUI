```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI Picker SegmentedStyle Image bad display (by Persilos)

A: By result of my finding I recommend to resize raster image explicitly to needed size (I used 24 x 24 for 1x) ... or find accepted vector format (probably PDF, but I'm not sure... trying to find some to test, and, btw, custom SW can also be designed)

Here is why... let start from API declaration

>     /// A `PickerStyle` where the options are contained in a segmented control.
>     ///
>     /// - Note: Only supports segments of type `Label` and `Image`. Passing any
>     /// other type of view will result in a visible, but empty, segment.
>     @available(iOS 13.0, OSX 10.15, tvOS 13.0, *)
>     @available(watchOS, unavailable)
>     public struct SegmentedPickerStyle : PickerStyle {

As it is seen only `Image` works, so any `sizeToFit` and `aspect`-like do not work, because they generate View.

Here is used manually pre-resized PNG image (any graphic designer can create perfect image of needed size, as it used to be for button icons)

Demo result:

![r8qdm](https://user-images.githubusercontent.com/62171579/174814485-1505af86-89bb-4824-b8ea-3ee79fab1fac.png)

Demo code:

    extension Image {
        static var carFill: Image {
            Image(systemName: "car.fill")
        }
        
        static var walking: Image {
            Image("pedestrian_small") // < explicitly resized 1x:24 x 24
        }
    }
    
    struct TestSegmentWithImages: View {
        @State var selectedIndex = 0
    
        @State var segmentOptions = [
            Image.carFill,
            Image.walking
        ]
    
        var body: some View {
            VStack {
                Image("pedestrian") // << original 400 x 400
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48)
                HStack {
                    Picker(selection: $selectedIndex, label: Text("")) {
                        segmentOptions[0]
                            .tag(0)
                        segmentOptions[1]
                            .tag(1)
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("test")
                }
            }
        }
        
    }

