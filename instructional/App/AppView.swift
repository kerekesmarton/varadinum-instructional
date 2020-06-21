import SwiftUI

struct AppView: View {
    
//    @ObservedObject var appData: T
    
//    init(data: T) {
//        appData = data
//    }
    
//    @State private var selection = 0
    
    @State var showingProfile = false

    var presentUserButton: some View {
        Button(action: {
            self.showingProfile.toggle()
        }) {
            Text("Profile")
        }.sheet(isPresented: $showingProfile) {
            UserView(data: UserData(feature: .auth))
        }
    }
    
    var body: some View {
        NavigationView {
            WorkshopsListView(workshopData: WorkshopsListData(feature: .all))
            .navigationBarTitle("Feed")
            .navigationBarItems(trailing: presentUserButton)
        }.anyView
    }
}
