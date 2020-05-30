import UIKit

protocol AppTaskable: UIWindowSceneDelegate, UIApplicationDelegate {}

struct AppTasks {
    
    let buildTask = BuildTask()
    @Inject var coreDataTask: CoreDataTask
    @Inject var pushNotificationTask: PushNotificationTask
    
    private var allTasks: [AppTaskable] {
        return [buildTask,
                coreDataTask,
                pushNotificationTask]
    }
    
    func forEach(_ body: (AppTaskable) throws -> Void) rethrows {
        try body(buildTask)
        try allTasks.forEach(body)
    }
}
