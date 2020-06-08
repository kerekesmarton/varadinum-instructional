import UIKit

protocol AppTaskable: UIWindowSceneDelegate, UIApplicationDelegate {}

struct AppTasks {
    
    let buildTask = BuildTask()
    @Inject var coreDataTask: CoreDataTask
    @Inject var pushNotificationTask: PushNotificationTask
    @Inject var authTask: AuthTask
    
    var allTasks: [AppTaskable] {
        return [buildTask,
                coreDataTask,
                authTask,
                pushNotificationTask]
    }
    
    func forEach(_ body: (AppTaskable) throws -> Void) rethrows {
        try body(buildTask)
        try allTasks.forEach(body)
    }
    
    func allSatisfy(_ predicate: (AppTaskable) throws -> Bool) rethrows -> Bool {
        try allTasks.allSatisfy(predicate)
    }
    
    
}
