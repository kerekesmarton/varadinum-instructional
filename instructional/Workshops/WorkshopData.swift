import SwiftUI

struct Workshop: Identifiable {
    var id: String
    var artist: Profile
    var image: URL
    var title: String
}

protocol WorkshopObservable: ObservableObject {
    var viewModel: WorkshopViewModel { get }
}

enum WorkshopViewModel {
    case result([Workshop])
    case loading
    case error(ServiceError)
}

class WorkshopData: ObservableObject, WorkshopObservable {
    @Published var viewModel = WorkshopViewModel.loading
    @Inject var api: Network
    
    init() {
        load()
    }
    
    func load() {
        api.fetch(query: GetWorkshopsQuery()) { [weak self] result in
          switch result {
          case .success(let graphQLResult):
            guard let data = graphQLResult.data else { return }
            let results = data.workshops.compactMap { $0?.generateEntity() }
            self?.viewModel = .result(results)
          case .failure(let error):
            self?.viewModel = .error(error)
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
