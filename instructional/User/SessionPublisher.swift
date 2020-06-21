import Combine
import Auth0
import Lock

class SessionPublisher: ObservableObject {
    @Published var credentials: Credentials?
    @Published var userInfo: UserInfo?
    
    var manager = CredentialsManager(authentication: Auth0.authentication())
    
    init() {
        manager.credentials { (error, credentials) in
            self.credentials = credentials
        }
    }
    
    func save(_ credentials: Credentials) {
        _ = manager.store(credentials: credentials)
        self.credentials = credentials
    }
    
    func save(_ userInfo: UserInfo) {
        self.userInfo = userInfo
    }
    
    func logout(completion: @escaping () -> Void ) {
        _ = manager.clear()
    }
}
