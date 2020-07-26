import UIKit
import Apollo
import Auth0

class BuildTask: NSObject, AppTaskable {
    
    private var authTask = AuthTask()
    private var pushNotificationTask = PushNotificationTask()
    private var coreDataTask = CoreDataTask()
    private var sessionPublisher = SessionPublisher()
    
    private lazy var dependencies = CoreServiceLocator {
        Register { self.coreDataTask }
        Register { self.pushNotificationTask }
        Register { self.authTask }
        Register { Network() }
        Register { self.sessionPublisher }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        dependencies.build()
    }
}

