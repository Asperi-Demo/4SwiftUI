```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Best Way to Update/Edit an Array Element in SwiftUI (by Clay_F)

A: This is the case when as I see it is more preferable to use ObservableObject for models, because it allows to pass by reference model object deep into hierarchy and keep it up to date during workflow.

Here is a solution. Tested with Xcode 11.4 / iOS 13.4

![VrWZq](https://user-images.githubusercontent.com/62171579/167099667-2fc722aa-9d4b-480e-899b-78ce3303bb87.gif)

```
class Training: ObservableObject, Identifiable {
    let id: String
    @Published var trainingName: String
    @Published var isRequired: Bool

    init(id: String, trainingName: String, isRequired: Bool) {
        self.id = id
        self.trainingName = trainingName
        self.isRequired = isRequired
    }
}

class GetTrainings: ObservableObject {
    @Published var items = [Training]()

    init() {
        self.items = [
            Training(id: "ttt1", trainingName: "Safety", isRequired: true),
            Training(id: "ttt2", trainingName: "Administrative", isRequired: false),
            Training(id: "ttt3", trainingName: "Computer", isRequired: true),
            Training(id: "ttt4", trainingName: "People", isRequired: true),
            Training(id: "ttt5", trainingName: "Managerial", isRequired: true),
        ]
    }
}

struct TrainingList: View {

    @ObservedObject var trainings = GetTrainings()

    var body: some View {
        NavigationView {
            VStack {
                List {

                    ForEach(trainings.items) { training in

                        HStack {
                            NavigationLink(destination: TrainingView(training: training)) {
                                Text("\(training.trainingName)")
                            }
                        }
                    }

                }
            }.navigationBarTitle("Training List")
            .onAppear {
                self.trainings.objectWillChange.send() // refresh
            }
        }
    }
}

struct TrainingView: View {

    @ObservedObject var training: Training

    var body: some View {

        VStack {

            Text("\(training.trainingName)").font(.body)
            Text("\(training.isRequired == true ? "Required Training" : "Training Not Required")")

            HStack {
                NavigationLink(destination: EditTraining(training: training)) {
                    Text("Edit Training Details")
                }
            }
        }.navigationBarTitle("\(training.trainingName) Page", displayMode: .inline)

    }
}

struct EditTraining: View {

    @ObservedObject var training: Training

    @State private var newName: String
    @State private var isRequiredTraining: Bool

    init(training: Training) {
        self.training = training
        self._newName = State(initialValue: training.trainingName)
        self._isRequiredTraining = State(initialValue: training.isRequired)
    }

    private func submitData() {

        let newName = self.newName
        let newBoolVal = self.isRequiredTraining

        print("Firebase Sync Id is :\(training.id) Text: \(newName) and Bool: \(newBoolVal)")

        self.training.trainingName = newName
        self.training.isRequired = newBoolVal
    }

    var body: some View {
        VStack {
            Form {
                Section (header: Text("Edit"))  {

                    Text("\(training.trainingName)")
                    /* TextField should Populate With passed In Training Name Here*/
                    TextField("New Name", text: self.$newName)
                    Toggle(isOn: self.$isRequiredTraining) {
                        Text("Is Required")
                    }
                }

                Section {

                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                            to:nil, from:nil, for:nil)
                        self.submitData()
                    }) {
                        Text("Submit")
                    }

                }
            }
        }.navigationBarTitle("Edit Training Page", displayMode: .inline)
    }
}
```
