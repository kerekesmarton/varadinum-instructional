import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0
    
    var profile = Profile(id: UUID().uuidString, name: "Timmy")
    
    var body: some View {
        TabView(selection: $selection) {
            ArtistsView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.3.fill")
                        Text("Artists")
                    }
            }
            .tag(0)
            ProfileView(profile: self.profile)
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
            .tag(1)
        }
    }
}
