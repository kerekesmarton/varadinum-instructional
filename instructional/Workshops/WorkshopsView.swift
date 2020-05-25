import SwiftUI

struct Workshop: Identifiable {
    var id: String
    var artist: Profile
    var image: URL
    var title: String
}

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

struct WorkshopsListView: View {
    
    var workshops: [Workshop]
    var body: some View {
        List(workshops) {
            WorkshopListItem(workshop: $0)
        }
    }
}
