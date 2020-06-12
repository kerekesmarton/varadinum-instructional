import SwiftUI

struct ProfileView: View {
    
    var profile: Entities.Profile
    @Inject var sessionManager: SessionPublisher
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    ProfileTitleView(profile: self.profile)
                    
                    Button(action: {}){
                        Text("Edit Profile")
                            .fontWeight(.bold)
                    }.frame(width: 400)
                        .padding()
                    
                    Divider()
                    
                    Spacer()
                    
                    WorkshopsListView(workshopData: WorkshopData(feature: .profile(self.profile)))
                    
                    Spacer()
                }
            }.navigationBarTitle(self.profile.name)
                .navigationBarItems(trailing: Button("Log out") {
                    self.sessionManager.logout {}
                })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: Entities.Profile(id: UUID().uuidString, name: "John"))
    }
}
