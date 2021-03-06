import SwiftUI

extension Entities {
    struct User: Identifiable {
        var id: String
        var name: String
        var workshops: [Entities.Workshop]?
    }
}

protocol UsersObservable: ObservableObject {
    var viewModel: UsersViewModel { get }
    func load()
}

enum UsersViewModel {
    case loading
    case error(ServiceError)
    case result([Entities.User])
}

class UsersListData: ObservableObject, UsersObservable {
    @Published var viewModel: UsersViewModel = .loading
    @Inject var api: Network
    
    func load() {
        api.fetch(query: GetUsersQuery()) { [weak self] (result) in
            switch result {
            case .success(let graphQLResult):
              guard let data = graphQLResult.data else { return }
              let results = data.getUsers?.compactMap { $0?.generateEntity() } ?? []
              self?.viewModel = .result(results)
            case .failure(let error):
              self?.viewModel = .error(error)
            }
        }
    }
}

extension GetUsersQuery.Data.GetUser: Model {
    func generateEntity() -> Entities.User? {
        Entities.User(id: id, name: name)
    }
}
