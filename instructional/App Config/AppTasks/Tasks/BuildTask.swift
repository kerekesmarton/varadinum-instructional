import UIKit
import Apollo
import Auth0

class BuildTask: NSObject, AppTaskable {
    
    private var credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    private var network = Network()
    private var apolloClient = ApolloClient(url: Environment.dev.url)
    private var authTask = AuthTask()
    private var pushNotificationTask = PushNotificationTask()
    private var coreDataTask = CoreDataTask()
    private var sessionPublisher = SessionPublisher()
    
    private lazy var dependencies = CoreServiceLocator {
        Register { self.coreDataTask }
        Register { self.pushNotificationTask }
        Register { self.authTask }
        Register { self.apolloClient }
        Register { self.network }
        Register { self.credentialsManager }
        Register { self.sessionPublisher }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        dependencies.build()
    }
}

