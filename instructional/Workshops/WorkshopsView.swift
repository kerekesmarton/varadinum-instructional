import SwiftUI

struct WorkshopListItem: View {
    
    var workshop: Workshop
    
    var body: some View {
        HStack{
            AsyncImage(url: self.workshop.image, placeholder: Text("💃🏻🕺🏽"))
            .shadow(radius: 3)
            
            Text(self.workshop.artist.name)
        }
    }
}

struct WorkshopsListView<T: WorkshopObservable>: View {
    
    @ObservedObject private var workshopData: T
    
    init(workshopData: T) {
        self.workshopData = workshopData
    }
    
    var body: some View {
        switch workshopData.viewModel {
        case .result(let workshops):
            return List(workshops) {
                WorkshopListItem(workshop: $0)
            }.anyView
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

struct WorkshopsView_Previews: PreviewProvider {
    
    class MockWorkshopData: WorkshopObservable, ObservableObject {
        var viewModel: WorkshopViewModel
        init(workshops: WorkshopViewModel) {
            self.viewModel = workshops
        }
    }
    
    static var previews: some View {
        
        let url = URL(string: "https://en.wikipedia.org/wiki/File:Machito_and_his_sister_Graciella_Grillo.jpg")!
        
        let profile = Profile(id: UUID().uuidString,
                            name: "Matt")
        
        let ws = Workshop(id: UUID().uuidString,
                          artist: profile,
                          image: url,
                          title: "Machito")
        
        
        return WorkshopsListView(workshopData: MockWorkshopData(workshops: .result([ws])))
    }
}
