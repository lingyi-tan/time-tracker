import SwiftUI


struct Response: Codable {
    let message: String
}

struct ActivityData: Codable {
    var mainActivity: String
    var mainCategory: String
    var secondActivity: String
    var secondCategory: String
}

struct FormView: View {
    @Binding var showingForm: Bool
    @State private var focus = 70.0
    @State private var isEditing = false
    
    @State private var mainActivity = ""
    @State private var secondActivity = ""
    
    
    enum Category: String, CaseIterable, Identifiable {
        case Reading, Coding, Agathe, Writing, Swedish, Learning, Others
        var id: Self { self }
    }
    
    
    @State private var mainCategory: Category = .Agathe
    @State private var secondCategory: Category = .Writing
    
    
    func submitActivity() {
        guard let url = URL(string: "https://127.0.0.1:5000track") else { return }

        let activityData = ActivityData(
            mainActivity: mainActivity,
            mainCategory: mainCategory.rawValue,
            secondActivity: secondActivity,
            secondCategory: secondCategory.rawValue
        )
        
        guard let jsonData = try? JSONEncoder().encode(activityData) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode(Response.self, from: data) {
                    print(response.message)
                } else {
                    print("Invalid response from server")
                }
            }
        }.resume()
    }
    
    var body: some View
    {
        VStack {
            
            
            Divider()
            
            // main activity
            HStack{
                
                Text("1.").font(.title3).padding()
                
                TextField("Main activity", text: $mainActivity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    Picker("", selection: $mainCategory) {
                        Text("Agathe").tag(Category.Agathe)
                        Text("Reading").tag(Category.Reading)
                        Text("Writing").tag(Category.Writing)
                        Text("Coding").tag(Category.Coding)
                        Text("Swedish").tag(Category.Swedish)
                        Text("Learning").tag(Category.Learning)
                        Text("Others").tag(Category.Others)
                    }
                    .background(Color.white)
                    .pickerStyle(.menu)
                    Spacer()
                }
                .padding()
            }
            
            HStack{
                
                Text("2.").font(.title3).padding()
                
                TextField("Secondary activity", text: $secondActivity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    Picker("", selection: $secondCategory) {
                        Text("Agathe").tag(Category.Agathe)
                        Text("Reading").tag(Category.Reading)
                        Text("Writing").tag(Category.Writing)
                        Text("Coding").tag(Category.Coding)
                        Text("Swedish").tag(Category.Swedish)
                        Text("Learning").tag(Category.Learning)
                        Text("Others").tag(Category.Others)
                    }
                    .background(Color.white)
                    .pickerStyle(.menu)
                    Spacer()
                }
                .padding()
                
                
            }
            
            HStack {
                Text("% Focus:")
                TextField("Focus", value: $focus,
                          formatter: NumberFormatter()
                ).frame(width: 35)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
            }
            .padding()
            
            Button("Submit") {
                submitActivity()
                self.showingForm = false
            }.foregroundColor(Color.green)
                .padding()
            //.background(Color.green)
            // .clipShape(Capsule())
        }
        .padding()
        //        .frame(width: 300, height: 300)
        .background(Color.white)
        
        
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FormView(showingForm: .constant(true))
                .previewInterfaceOrientation(.portrait)
        }
    }
}
