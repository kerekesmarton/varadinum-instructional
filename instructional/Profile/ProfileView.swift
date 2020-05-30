import SwiftUI

struct Profile: Identifiable {
    var id: String    
    var name: String
}

struct ProfileView: View {
    
    var profile: Profile
    
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
                    
                    WorkshopsListView(workshopData: WorkshopData())
                    
                    Spacer()
                }
            }.navigationBarTitle(self.profile.name)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: Profile(id: UUID().uuidString, name: "John"))
    }
}
