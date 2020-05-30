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
        List(workshopData.workshops) {
            WorkshopListItem(workshop: $0)
        }
    }
}

struct WorkshopsView_Previews: PreviewProvider {
    
    class MockWorkshopData: WorkshopObservable, ObservableObject {
        @Published var workshops = [Workshop]()
        
        init(workshops: [Workshop]) {
            self.workshops = workshops
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
        
        
        return WorkshopsListView(workshopData: MockWorkshopData(workshops: [ws]))
    }
}
