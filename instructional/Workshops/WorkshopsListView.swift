import SwiftUI

struct WorkshopListItem: View {
    
    var workshop: Entities.Workshop
    
    var body: some View {
        HStack{
            AsyncImage(url: self.workshop.image, placeholder: Text("💃🏻🕺🏽"))
            
            VStack(alignment: .leading) {
                Text(self.workshop.title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            }
        }
    }
}

struct WorkshopsListView<T: WorkshopObservable>: View {
    
    @ObservedObject private var workshopData: T
    
    init(workshopData: T) {
        self.workshopData = workshopData
    }
    
    private func makeView(_ workshops: [Entities.Workshop]) -> AnyView {
        return List(workshops) {
            WorkshopListItem(workshop: $0)
        }.anyView
    }
    
    var body: some View {
        switch workshopData.viewModel {
        case .result(let workshops):
            return makeView(workshops)
        case .error(let error):
            return makeErrorView(error)
        case .loading:
            return makeLoadingView()
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
        
        let profile = Entities.User(id: UUID().uuidString,
                            name: "Matt")
        
        let ws = Entities.Workshop(id: UUID().uuidString,
                          artist: profile,
                          image: url,
                          title: "Machito")
        
        return WorkshopsListView(workshopData: MockWorkshopData(workshops: .result([ws])))
    }
}
