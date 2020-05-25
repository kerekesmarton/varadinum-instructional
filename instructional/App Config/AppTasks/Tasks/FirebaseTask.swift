import UIKit
import Firebase

class FirebaseTask: NSObject, AppTaskable {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
    }
}
