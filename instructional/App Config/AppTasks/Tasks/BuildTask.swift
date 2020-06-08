import UIKit
import Apollo
import Auth0

class BuildTask: NSObject, AppTaskable {
    private let dependencies = CoreServiceLocator {
        Register { CoreDataTask() }
        Register { PushNotificationTask() }
        Register { AuthTask() }
        Register { ApolloClient(url: Environment.dev.url)}
        Register { Network() }
        Register {  CredentialsManager(authentication: Auth0.authentication()) }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        dependencies.build()
    }
}

