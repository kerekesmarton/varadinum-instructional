import SwiftUI

struct ArtistsView: View {
    
    let salsaArtists = ["Terry y Cecile","Adolfo y Tania","Jorge y Wuale"]
    let bachataArtists = ["Honda","Nissan","Suzuki"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Salsa").font(.title)) {
                    ForEach(0 ..< salsaArtists.count) {
                        Text(self.salsaArtists[$0])
                    }
                }
                Section(header: Text("Bachata").font(.title)) {
                    ForEach(0 ..< bachataArtists.count) {
                        Text(self.bachataArtists[$0])
                    }
                }
            }.navigationBarTitle("Workshops")
        }
    }
}

struct ArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsView()
    }
}
