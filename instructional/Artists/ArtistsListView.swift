import SwiftUI

struct ArtistsListView<T: ArtistsObservable>: View {
    
    @ObservedObject private var artistsData: T
    
    init(artistsData: T) {
        self.artistsData = artistsData
    }
    
    private func makeView(_ artists: ([Entities.User])) -> AnyView {
        return List(artists) {
            NavigationLink($0.name,
                           destination: WorkshopsListView(workshopData: WorkshopData(feature: .profile($0)))
            )
        }.navigationBarTitle("Artists").anyView
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
        }
    }
}

struct ArtistsView_Previews: PreviewProvider {
    
    class MockArtistsData: ArtistsObservable {
        var viewModel: ArtistsViewModel
        
        init(viewModel: ArtistsViewModel) {
            self.viewModel = viewModel
        }
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
        return ArtistsListView(artistsData: data)
    }
}
