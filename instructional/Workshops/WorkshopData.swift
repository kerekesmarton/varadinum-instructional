import SwiftUI

extension Entities {
    struct Workshop: Identifiable {
        var id: String
        var artist: Profile
        var image: URL
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

class WorkshopData: ObservableObject, WorkshopObservable {
    enum Feature {
        case all
        case profile(Entities.Profile)
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
                let results = data.workshops.compactMap { $0?.generateEntity() }
                self?.viewModel = .result(results)
            case .failure(let error):
                self?.viewModel = .error(error)
            }
        }
    }
    
    private func load(profile: Entities.Profile) {
        api.fetch(query: GetUserQuery(input: UserWhereUniqueInput(id: profile.id))) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                guard let data = graphQLResult.data else {
                    self?.viewModel = .error(.unknown)
                    return
                }
                guard let result = data.user?.generateEntity(),
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
        case .profile(let profile):
            load(profile: profile)
        }
    }
}

extension GetWorkshopsQuery.Data.Workshop: Model {
    func generateEntity() -> Entities.Workshop? {
        guard let author = author else {
            return nil
        }
        let profile = Entities.Profile(id: author.id, name: author.name)
        return Entities.Workshop(id: id, artist: profile, image: URL(string: preview)!, title: title)
    }
}

extension GetUserQuery.Data.User: Model {
    func generateEntity() -> Entities.Profile? {
        
        var profile = Entities.Profile(id: id, name: name)
        profile.workshops = workshops?.compactMap { Entities.Workshop(id: $0.id, artist: profile, image: URL(string: $0.preview)!, title: $0.title) }
        
        return profile
    }
}
