import Foundation
import Lock

class AuthTask: NSObject, AppTaskable {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      return Lock.resumeAuth(url, options: options)
    }
    
}
