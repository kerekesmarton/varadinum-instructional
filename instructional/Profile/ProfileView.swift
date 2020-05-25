import SwiftUI

struct Profile: Identifiable {
    var id: String    
    var name: String
}

struct ProfileView: View {
    
    var profile: Profile
    
    func workshops() -> [Workshop] {
        return [Workshop(id: UUID().uuidString,
                 artist: self.profile,
                 image: URL(string: "https://unsplash.com/photos/POd35V_uE4k")!,
                 title: "Ballet"),
        Workshop(id: UUID().uuidString,
                 artist: self.profile,
                 image: URL(string: "https://unsplash.com/photos/Etxf65FaTrs")!,
                 title: "Street")]
    }
    
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
                    
                    WorkshopsListView(workshops: self.workshops())
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
