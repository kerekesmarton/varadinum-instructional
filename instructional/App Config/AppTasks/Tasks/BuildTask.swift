import UIKit

class BuildTask: NSObject, AppTaskable {
    private let dependencies = CoreServiceLocator {
        Register("firebase") { FirebaseTask() }
        Register("coredata") { CoreDataTask() }
        Register("pushNotification") { PushNotificationTask() }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        dependencies.build()
    }
}

