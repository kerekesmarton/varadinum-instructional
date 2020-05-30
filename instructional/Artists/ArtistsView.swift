import SwiftUI

struct ArtistsView<T: ArtistsObservable>: View {
    
    @ObservedObject private var artistsData: T
    
    init(artistsData: T) {
        self.artistsData = artistsData
    }
    
    var body: some View {
        NavigationView<AnyView> {
            switch artistsData.viewModel {
            case .result(let artists):
                return List(artists) {
                    Text($0.name)
                }.navigationBarTitle("Artists").anyView
            case .error(let error):
                return VStack {
                    Text(error.localizedDescription)
                }.anyView
            case .loading:
                return VStack {
                    Text("Loading")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }.anyView
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
        let matt = Profile(id: UUID().uuidString,
                              name: "Matt")
        let dave = Profile(id: UUID().uuidString,
                              name: "Dave")
        let dawson = Profile(id: UUID().uuidString,
                              name: "Dawson")
        let tom = Profile(id: UUID().uuidString,
                              name: "Tom")
        
        let data = MockArtistsData(viewModel: .result([matt,dave,dawson,tom]))
        return ArtistsView(artistsData: data)
    }
}
