import SwiftUI

struct AppView: View {
    
    @State var showingProfile = false

    var presentUserButton: some View {
        Button(action: {
            self.showingProfile.toggle()
        }) {
            Image(systemName: "person.fill")
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
