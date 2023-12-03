import SwiftUI


struct ContentView: View {
    @State private var showingForm = true

    var body: some View {
        VStack {
            Text("Hello!")
                .font(.largeTitle)
                .padding()
            
            Text("what you are doing?").font(.title2).padding()
            
            FormView(showingForm: $showingForm)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
        }.background(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
