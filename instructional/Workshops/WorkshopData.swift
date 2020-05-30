import SwiftUI

struct Workshop: Identifiable {
    var id: String
    var artist: Profile
    var image: URL
    var title: String
}

protocol WorkshopObservable: ObservableObject {
    var workshops: [Workshop] { get }
}

class WorkshopData: ObservableObject, WorkshopObservable {
    @Published var workshops = [Workshop]()
    @Inject var api: Network
    
    init() {
        load()
    }
    
    func load() {
        api.apollo.fetch(query: GetWorkshopsQuery()) { [weak self] result in
          switch result {
          case .success(let graphQLResult):
            guard let data = graphQLResult.data else { return }
            self?.workshops = data.workshops.compactMap { $0?.generateEntity() }
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
    }
}

extension GetWorkshopsQuery.Data.Workshop: Model {
    func generateEntity() -> Workshop? {
        guard let author = author else {
            return nil
        }
        let profile = Profile(id: author.id, name: author.name)
        return Workshop(id: id, artist: profile, image: URL(string: preview)!, title: title)
    }
}
