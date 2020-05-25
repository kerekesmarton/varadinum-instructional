import UIKit

class BuildTask: NSObject, AppTaskable {
    private let dependencies = CoreServiceLocator {
        Register { FirebaseTask() }
        Register { CoreDataTask() }
        Register { PushNotificationTask() }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        dependencies.build()
    }
}

