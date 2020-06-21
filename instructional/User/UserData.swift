import SwiftUI
import Auth0

enum UserViewModel {
    case result(Entities.User)
    case login(completion: AuthCompletion)
    case loading
    case error(ServiceError)
}

enum UserFeature {
    case user(id: String)
    case auth
}

protocol UserObservable: ObservableObject {
    var viewModel: UserViewModel { get }
    
    func logout()
}

class UserData: UserObservable {
    @Published var viewModel: UserViewModel = .loading
    
    @Inject var sessionManager: SessionPublisher
    @Inject var api: Network
    
    let feature: UserFeature
    init(feature: UserFeature) {
        self.feature = feature
        load()
    }
    
    func logout() {
        sessionManager.logout {
            self.viewModel = .login(completion: {
                self.load()
            })
        }
    }
    
    func load() {
        let id: String
        switch feature {
        case .auth:
            guard let tempId = sessionManager.credentials?.idToken else {
                self.viewModel = .login(completion: {
                    self.load()
                })
                return
            }
            id = tempId
        case .user(id: let userId):
            id = userId
        }
        viewModel = .loading
        
        api.fetch(query: GetUserQuery(userID: id)) { [weak self] (result) in
            switch result {
            case .success(let graphQLResult):
                guard let data = graphQLResult.data,
                    let results = data.getUser?.generateEntity()
                    else {
                        self?.viewModel = .error(ServiceError.client("fetching user data"))
                        return
                }
                self?.viewModel = .result(results)
            case .failure(let error):
                self?.viewModel = .error(error)
            }
        }
    }
}
