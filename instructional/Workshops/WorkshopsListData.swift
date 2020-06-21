import SwiftUI

extension Entities {
    struct Workshop: Identifiable {
        var id: String
        var artist: User?
        var image: URL?
        var title: String
    }
}

protocol WorkshopObservable: ObservableObject {
    var viewModel: WorkshopViewModel { get }
}

enum WorkshopViewModel {
    case result([Entities.Workshop])
    case loading
    case error(ServiceError)
}

class WorkshopsListData: ObservableObject, WorkshopObservable {
    enum Feature {
        case all
        case profile(Entities.User)
    }
    
    @Published var viewModel = WorkshopViewModel.loading
    @Inject var api: Network
    private var feature: Feature
    
    init(feature: Feature) {
        self.feature = feature
        load(feature: feature)
    }
    
    private func loadAll() {
        api.fetch(query: GetWorkshopsQuery()) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                guard let data = graphQLResult.data else { return }
                let results = data.getWorkshops?.compactMap { $0?.generateEntity() } ?? []
                self?.viewModel = .result(results)
            case .failure(let error):
                self?.viewModel = .error(error)
            }
        }
    }
    
    private func load(user: Entities.User) {
        api.fetch(query: GetUserQuery(userID: user.id)) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                guard let data = graphQLResult.data else {
                    self?.viewModel = .error(.unknown)
                    return
                }
                guard let result = data.getUser?.generateEntity(),
                    let workshops = result.workshops else {
                        self?.viewModel = .error(.empty)
                        return
                }
                self?.viewModel = .result(workshops)
            case .failure(let error):
                self?.viewModel = .error(error)
            }
        }
    }
    
    func load(feature: Feature) {
        
        switch feature {
        case .all:
            loadAll()
        case .profile(let user):
            load(user: user)
        }
    }
}

extension GetWorkshopsQuery.Data.GetWorkshop: AssisttedModel {
    
    func generateEntity(with associate: Entities.User) -> Entities.Workshop? {
        return Entities.Workshop(id: id, artist: associate, image: URL(string: coverImageUrl)!, title: title)
    }
    
    func generateEntity() -> Entities.Workshop? {
        return Entities.Workshop(id: id, artist: nil, image: URL(string: coverImageUrl)!, title: title)
    }
}
//
extension GetUserQuery.Data.GetUser: Model {
    func generateEntity() -> Entities.User? {

        var user = Entities.User(id: id, name: name)
        user.workshops = workshops.compactMap {
            guard let ws = $0 else {
                return nil
            }
            return Entities.Workshop(id: ws.id, artist: user, image: URL(string: ws.coverImageUrl), title: ws.title)
        }
            
        return user
    }
}
