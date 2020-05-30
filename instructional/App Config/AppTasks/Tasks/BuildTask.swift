import UIKit

class BuildTask: NSObject, AppTaskable {
    private let dependencies = CoreServiceLocator {
        Register { CoreDataTask() }
        Register { PushNotificationTask() }
        Register { Network() }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        dependencies.build()
    }
}

