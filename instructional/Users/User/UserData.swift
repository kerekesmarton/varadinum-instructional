import SwiftUI
import Auth0
import Combine

enum UserViewModel {
    case result(Entities.User)
    case login(session: SessionPublisher)
    case signup(userInfo: UserInfo)
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
    
    @Inject var sessionPublisher: SessionPublisher
    @Inject var api: Network
    
    init(feature: UserFeature) {
        switch feature {
        case .auth:
            resolveAuthSession()
            return
        case .user(id: let userId):
            loadUser(userId) { [weak self] results in
                switch results {
                case .success(result: let user):
                    self?.viewModel = .result(user)
                case .failure(error: let error):
                    self?.viewModel = .error(ServiceError(from: error))
                }
            }
        }
    }
    
    func logout() {
        sessionPublisher.logout()
    }
    
    private var cancellableSet: Set<AnyCancellable> = []

    private func resolveAuthSession() {
        viewModel = .loading
        sessionPublisher.$viewModel
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] (result) in
                switch result {
                case .error(let errorString):
                    self?.viewModel = .error(ServiceError.client(errorString))
                case .guest:
                    guard let session = self?.sessionPublisher else { return }
                    self?.viewModel = .login(session: session)
                case .hasSession(user: let userInfo, credentials: let credentials):
                    self?.loadUser(info: userInfo, credentials: credentials)
                case .loading:
                    self?.viewModel = .loading
                }
            }
            .store(in: &cancellableSet)
    }
    
    private func loadUser(info: UserInfo, credentials: Credentials) {
        guard let id = credentials.idToken else {
            viewModel = .error(ServiceError.empty)
            return
        }
        
        loadUser(id) { [weak self] results in
            switch results {
            case .success(result: let user):
                self?.viewModel = .result(user)
            case .failure(error: let error):
                
                let error = ServiceError(from: error)
                switch error {
                case .empty:
                    self?.viewModel = .signup(userInfo: info)
                default:
                    self?.viewModel = .error(ServiceError(from: error))
                }
            }
        }
    }
    
    private func loadUser(_ id: String, completion: @escaping (Result<Entities.User>) -> Void) {
        viewModel = .loading
        api.fetch(query: GetUserQuery(userID: id)) { (result) in
            switch result {
            case .success(let graphQLResult):
                guard let data = graphQLResult.data,
                    let user = data.getUser?.generateEntity()
                    else {
                        completion(.failure(error: ServiceError.empty))
                        return
                }
                completion(.success(result: user))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}

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

