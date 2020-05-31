import UIKit
import Apollo

class BuildTask: NSObject, AppTaskable {
    private let dependencies = CoreServiceLocator {
        Register { CoreDataTask() }
        Register { PushNotificationTask() }
        Register { Network() }
        Register { ApolloClient(url: URL(string: "https://eu1.prisma.sh/kerekes-marton-d1867d/instructional-cloud/dev")!) }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        dependencies.build()
    }
}

