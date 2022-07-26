```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Optional Binding in parameter SwiftUI (by Sofiane Lyno)

A: There is special Binding constructor for this purpose

```
SingleFileView(showSheetModifFile: Binding(self.$showModifFileSheet), 
   fileToModify: Binding(self.$fileToModify))
```

Update: alternate solution

```
struct FileDemoView: View {
    @State var showModifFileSheet : Bool? = false
    @State var fileToModify : File? = File()

    var body: some View {
        SingleFileView(showSheetModifFile: $showModifFileSheet, fileToModify: $fileToModify)
    }

}


struct SingleFileView: View {
    @Binding var showSheetModifFile : Bool?
    @Binding var fileToModify : File?


    init(showSheetModifFile : Binding<Bool?> = .constant(nil), fileToModify : Binding<File?> = .constant(nil)) {
        _showSheetModifFile = showSheetModifFile
        _fileToModify = fileToModify
    }

    var body: some View {
        Text("")
    }
}
```
