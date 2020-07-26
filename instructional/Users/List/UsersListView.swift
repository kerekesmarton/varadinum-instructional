import SwiftUI

struct UsersListView<T: UsersObservable>: View {
    
    @ObservedObject private var artistsData: T
    
    init(artistsData: T) {
        self.artistsData = artistsData
    }
    
    private func makeView(_ artists: ([Entities.User])) -> AnyView {
        return List(artists) {
            NavigationLink($0.name,
                           destination: WorkshopsListView(workshopData: WorkshopsListData(feature: .profile($0)))
            )
        }
        .navigationBarTitle("Artists")
        .anyView
    }
    
    var body: some View {
        NavigationView<AnyView> {
            switch artistsData.viewModel {
            case .result(let artists):
                return makeView(artists)
            case .error(let error):
                return makeErrorView(error)
            case .loading:
                return makeLoadingView()
            }
        }.onAppear {
            self.artistsData.load()
        }
    }
}

struct ArtistsView_Previews: PreviewProvider {
    
    class MockArtistsData: UsersObservable {
        var viewModel: UsersViewModel
        
        init(viewModel: UsersViewModel) {
            self.viewModel = viewModel
        }
        
        func load() {}
    }
    
    static var previews: some View {
        let matt = Entities.User(id: UUID().uuidString,
                              name: "Matt")
        let dave = Entities.User(id: UUID().uuidString,
                              name: "Dave")
        let dawson = Entities.User(id: UUID().uuidString,
                              name: "Dawson")
        let tom = Entities.User(id: UUID().uuidString,
                              name: "Tom")
        
        let data = MockArtistsData(viewModel: .result([matt,dave,dawson,tom]))
        return UsersListView(artistsData: data)
    }
}
