import Combine
import Auth0
import Lock

class SessionPublisher: ObservableObject {
    @Published var credentials: Credentials?
    
    @Inject var manager: CredentialsManager
    
    func save(credentials: Credentials) {
        _ = manager.store(credentials: credentials)
        self.credentials = credentials
    }
    
    func logout(completion: @escaping () -> Void ) {
        manager.clear()
    }
}
