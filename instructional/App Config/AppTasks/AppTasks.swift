import UIKit

protocol AppTaskable: UIWindowSceneDelegate, UIApplicationDelegate {}

struct AppTasks {
    
    let buildTask = BuildTask()
    @Inject("firebase") var firebaseTask: FirebaseTask
    @Inject("coredata") var coreDataTask: CoreDataTask
    @Inject("pushNotification") var pushNotificationTask: PushNotificationTask
    
    private var allTasks: [AppTaskable] {
        return [buildTask,
                firebaseTask,
                coreDataTask,
                pushNotificationTask]
    }
    
    func forEach(_ body: (AppTaskable) throws -> Void) rethrows {
        try body(buildTask)
        try allTasks.forEach(body)
    }
}
