import UIKit

protocol AppTaskable: UIWindowSceneDelegate, UIApplicationDelegate {}

struct AppTasks {
    
    let buildTask = BuildTask()
    @Inject var firebaseTask: FirebaseTask
    @Inject var coreDataTask: CoreDataTask
    @Inject var pushNotificationTask: PushNotificationTask
    
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
