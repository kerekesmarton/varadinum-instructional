import UIKit
import Apollo

class BuildTask: NSObject, AppTaskable {
    private let dependencies = CoreServiceLocator {
        Register { CoreDataTask() }
        Register { PushNotificationTask() }
        Register { ApolloClient(url: Environment.dev.url)}
        Register { Network() }        
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        dependencies.build()
    }
}

