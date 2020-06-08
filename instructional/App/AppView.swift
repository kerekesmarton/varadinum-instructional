import SwiftUI

struct AppView<T: AppObservable>: View {
    
    @ObservedObject var appData: T
    
    init(data: T) {
        appData = data
    }
    
    @State private var selection = 0
    
    var profile = Entities.Profile(id: UUID().uuidString, name: "Timmy")
    
    var body: some View {
        switch appData.viewModel {
        case .start:
            return TabView(selection: $selection) {
                ArtistsListView(artistsData: ArtistsData()).tabItem
                ProfileView(profile: self.profile).tabItem
            }.anyView
        case .authRequired:
            return AuthHostView(AuthView()).anyView
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
