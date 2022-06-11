```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Generic View SwiftUI with ViewModel (by theMouk)

A: Here is how it could be used (due to absent all types I replicate those with simple stub). 

Tested & works with Xcode 11.2 / iOS 13.2

Please note, it is not allowed to place different types in one container, so if you intended to do this you'll need type erasure, like SwiftUI `AnyView` do for `View`.

    protocol BaseQuestionViewModel {
    }
    
    struct YesNoQuestionViewModel: BaseQuestionViewModel {
    }
    
    protocol PQuestionView: View {
        associatedtype VM where VM : BaseQuestionViewModel
        var vm: Self.VM { get }
    }
    
    struct test: PQuestionView {
        var vm = YesNoQuestionViewModel()
        var body: some View{
            VStack{
                Text("Yes")
            }
        }
    }
    
    struct QuestionsHolder<T: PQuestionView>: View {
        var questionViews: [T]
        var body: some View {
            ForEach(0..<questionViews.count) { i in
                self.questionViews[i]
            }
        }
    }
    
    struct TestViewGenerics_Previews: PreviewProvider {
        static var previews: some View {
            List {
                QuestionsHolder(questionViews: [test(), test(), test()])
            }
        }
    }

