import UIKit
import CoreData

protocol ViewContextProvider {
    var persistentContainer: NSPersistentContainer? { get }
}

class CoreDataTask: NSObject, AppTaskable, ViewContextProvider {
    
    var persistentContainer: NSPersistentContainer?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        persistentContainer = makePersistentContainer(completion: { (description, error) in
            
        })
    }
    
    func makePersistentContainer(completion: @escaping ((NSPersistentStoreDescription, Error?) -> Void)) -> NSPersistentContainer? {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "instructional")
        container.loadPersistentStores { (storeDescription, error) in
            completion(storeDescription, error)
        }
        return container
    }

    // MARK: - Core Data Saving support

    func saveContext() throws {
        guard let context = persistentContainer?.viewContext else {
            return
        }
        if context.hasChanges {
            try context.save()
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        try? saveContext()
    }
}
