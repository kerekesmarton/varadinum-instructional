import SwiftUI

protocol ArtistsObservable: ObservableObject {
    var viewModel: ArtistsViewModel { get }
}

enum ArtistsViewModel {
    case loading
    case error(ServiceError)
    case result([Profile])
}


class ArtistsData: ObservableObject, ArtistsObservable {
    @Published var viewModel: ArtistsViewModel = .loading
    @Inject var api: Network
    
    init() {
        load()
    }
    
    func load() {
        api.fetch(query: GetUsersQuery()) { [weak self] (result) in
            switch result {
            case .success(let graphQLResult):
              guard let data = graphQLResult.data else { return }
              let results = data.users.compactMap { $0?.generateEntity() }
              self?.viewModel = .result(results)
            case .failure(let error):
              self?.viewModel = .error(error)
            }
        }
    }
}

extension GetUsersQuery.Data.User: Model {
    func generateEntity() -> Profile? {
        Profile(id: id, name: name)
    }
}
