import SwiftUI

extension Entities {
    struct Profile: Identifiable {
        var id: String
        var name: String
        var workshops: [Entities.Workshop]?
    }
}

protocol ArtistsObservable: ObservableObject {
    var viewModel: ArtistsViewModel { get }
}

enum ArtistsViewModel {
    case loading
    case error(ServiceError)
    case result([Entities.Profile])
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
        
//        api.fetch(query: <#T##GraphQLQuery#>, completion: <#T##(Result<GraphQLResult<GraphQLSelectionSet>, ServiceError>) -> Void#>)
    }
}

extension GetUsersQuery.Data.User: Model {
    func generateEntity() -> Entities.Profile? {
        Entities.Profile(id: id, name: name)
    }
}
