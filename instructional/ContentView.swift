import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0
    
    var profile = Entities.Profile(id: UUID().uuidString, name: "Timmy")
    
    var body: some View {
        TabView(selection: $selection) {
            ArtistsListView(artistsData: ArtistsData()).tabItem
            ProfileView(profile: self.profile).tabItem                
        }
    }
}

extension ArtistsListView {
    var tabItem: some View {
        return self.tabItem {
                VStack {
                    Image(systemName: "person.3.fill")
                    Text("Artists")
            }.tag(0)
        }
    }
}

extension ProfileView {
    var tabItem: some View {
        return self.tabItem {
                VStack {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .tag(1)
    }
}
