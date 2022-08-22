// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

import PhotosUI
import Photos

#if canImport(Charts)
@available (iOS 16, *)
struct TestPHAssertFromPhotoPicker: View {
    @State private var selectedPhotosPickerItem: PhotosPickerItem?
    @State private var enabled = false
    var body: some View {
        PhotosPicker(selection: $selectedPhotosPickerItem, matching: .any(of: [.images]), photoLibrary: .shared()) {
            Text("Select photos")
        }
        .disabled(!enabled)
        .onChange(of: selectedPhotosPickerItem) { newItem in
            if let newItem = newItem, let localID = newItem.itemIdentifier {
                let result = PHAsset.fetchAssets(withLocalIdentifiers: [localID], options: nil)
                if let asset = result.firstObject {
                    print("Got " + asset.debugDescription)
                }
                
                Task {
                    if let data = try? await newItem.loadTransferable(type: Data.self) {
                        let _ =  UIImage(data: data)
                    }
                }
            }
        }
        .onAppear {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                enabled = status == .authorized
            }
        }
    }
}

@available (iOS 16, *)
struct TestPHAssertFromPhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        TestPHAssertFromPhotoPicker()
    }
}
#endif
